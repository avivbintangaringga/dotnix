{
  self,
  dotnix,
  ...
}:
{
  dotnix.kvm = {
    includes = with dotnix; [
      looking-glass
      vfio
      kvmfr
    ];

    homeManager.xdg.desktopEntries.win11 = {
      categories = [ "System" ];
      exec = "vm-start tiny11";
      icon = self + "/assets/icons/windows11.png";
      name = "Windows 11";
      terminal = false;
      type = "Application";
    };

    nixos =
      {
        user,
        lib,
        pkgs,
        ...
      }:
      let
        qemupkg = pkgs.qemu_kvm;
      in
      {
        environment.systemPackages = with pkgs; [
          virt-manager
          virt-viewer
          spice
          spice-gtk
          spice-protocol
          adwaita-icon-theme
          virtiofsd

          (pkgs.writeShellScriptBin "lg" ''
            looking-glass-client -F audio:micDefault=allow audio:micSHowIndicator=no audio:periodSize=512
          '')

          (pkgs.writeShellApplication {
            bashOptions = [ ];
            name = "vm-start";
            runtimeInputs = [
              libnotify
            ];
            text = ''
              if [[ -z ''$1 ]]
              then
                echo "VM Name is required!"
                exit 1
              fi

              VM=''$1

              notify-send "Starting vm: ''$VM..." -i ${self + "/assets/icons/vm.png"}
              virsh -c qemu:///system start "''$VM"

              notify-send "Starting Looking Glass Client..." -i ${self + "/assets/icons/lg.png"}
              lg
            '';
          })

          (pkgs.writeShellScriptBin "vm_waybar_hook" ''
            ACTION=$1

            get() {
              VM_LIST=$(virsh -c qemu:///system list --state-running --name | awk NF)
              RUNNING_VM_COUNT=$(echo -n "$VM_LIST" | grep "" -c)
              FIRST_RUNNING_VM=$(echo -n "$VM_LIST" | head -1)

              if [[ $RUNNING_VM_COUNT -ge 1 ]]
              then
                if [[ $RUNNING_VM_COUNT -eq 1 ]]
                then
                  echo "  |  $FIRST_RUNNING_VM"
                else
                  echo "  |  $RUNNING_VM_COUNT VMs"
                fi
              fi
            }

            click() {
              RUNNING_VM_COUNT=$(virsh -c qemu:///system list --state-running --name | awk NF | grep "" -c)

              if [[ $RUNNING_VM_COUNT -ge 1 ]]
              then
                if [[ $RUNNING_VM_COUNT -eq 1 ]]
                then
                  lg
                else
                  virt-manager
                fi
              fi
            }

            case $ACTION in
              "get")
                get
                  ;;
              "click")
                click
                  ;;
              *)
                echo "Unknown action!"
                exit 1
                  ;;
            esac
          '')
        ];
        services.spice-vdagentd.enable = true;
        networking.firewall.interfaces."virbr*" = {
          allowedTCPPorts = [ 53 ];
          allowedUDPPorts = [
            53
            67
            547
          ];
        };
        systemd = {
          services = {
            libvirt-guests.wantedBy = lib.mkForce [ ];
            libvirtd = {
              after = [ "graphical.target" ];
              wantedBy = lib.mkForce [ ];
            };
          };
          targets.graphical.wants = [ "libvirtd.service" ];
        };
        users.users.${user.userName}.extraGroups = [
          "libvirtd"
          "kvm"
        ];
        virtualisation = {
          libvirtd = {
            enable = true;
            hooks.qemu."gpuswitch" = pkgs.writeShellScript "gpuswitch-hook" ''
              readonly GUEST_NAME="$1"
              readonly HOOK_NAME="$2"
              readonly STATE_NAME="$3"

              start_hook() {
                systemctl stop lactd
                systemctl stop nvidia-powerd
                rmmod nvidia_drm
                rmmod nvidia_uvm
                rmmod nvidia_modeset
                rmmod nvidia
                modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1 vfio
                /run/current-system/sw/bin/virsh nodedev-detach pci_0000_01_00_0
              }

              revert_hook() {
                /run/current-system/sw/bin/virsh nodedev-reattach pci_0000_01_00_0
                rmmod vfio_pci vfio_pci_core vfio_iommu_type1 vfio
                modprobe -i nvidia
                modprobe -i nvidia_uvm
                modprobe -i nvidia_modeset
                modprobe -i nvidia_drm
                systemctl restart nvidia-powerd
                systemctl restart lactd
              }

              if [[ "$HOOK_NAME" == "prepare" && "$STATE_NAME" == "begin" ]]; then
                if [[ "$GUEST_NAME" == "tiny11" || "$GUEST_NAME" == "win10" ]]
                then
                  start_hook
                fi
              elif [[ "$HOOK_NAME" == "release" && "$STATE_NAME" == "end" ]]; then
                if [[ "$GUEST_NAME" == "tiny11" || "$GUEST_NAME" == "win10" ]]
                then
                  revert_hook
                fi
              fi
            '';
            onBoot = "ignore";
            onShutdown = "shutdown";
            qemu = {
              package = qemupkg;
              runAsRoot = true;
              swtpm.enable = true;
              verbatimConfig = ''
                namespaces = []
                cgroup_device_acl = [
                  "/dev/null",
                  "/dev/full",
                  "/dev/zero",
                  "/dev/random",
                  "/dev/urandom",
                  "/dev/ptmx",
                  "/dev/kvm",
                  "/dev/kqemu",
                  "/dev/rtc",
                  "/dev/hpet",
                  "/dev/vfio/vfio",
                  "/dev/kvmfr0",
                  "/dev/nvidiactl",
                  "/dev/nvidia0",
                  "/dev/nvidia-modeset",
                  "/dev/dri/renderD128"
                ]
              '';
              vhostUserPackages = with pkgs; [
                virtiofsd
              ];
            };
          };
          spiceUSBRedirection.enable = true;
        };
      };
  };
}
