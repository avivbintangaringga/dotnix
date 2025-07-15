{
  lib,
  config,
  pkgs,
  userdata,
  ...
}:
{
  options = {
    setup.misc.virt-manager.enable = lib.mkEnableOption "virt-manager";
  };

  config = lib.mkIf config.setup.misc.virt-manager.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      adwaita-icon-theme
      virtiofsd
    ];

    # nixpkgs.overlays = [
    #   (self: super: {
    #     qemu_kvm = super.qemu_kvm.overrideAttrs (oldAttrs: {
    #       postPatch = oldAttrs.postPatch + ''
    #         sed -i 's/GUI_REFRESH_INTERVAL_DEFAULT    30/GUI_REFRESH_INTERVAL_DEFAULT    7/g' include/ui/console.h
    #       '';
    #     });
    #   })
    # ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [ pkgs.OVMFFull.fd ];
          };
          vhostUserPackages = with pkgs; [ virtiofsd ];
          verbatimConfig = ''
            cgroup_device_acl = [
              "/dev/null",
              "/dev/full",
              "/dev/zero",
              "/dev/random",
              "/dev/urandom",
              "/dev/ptmx",
              "/dev/kvm",
              "/dev/nvidiactl",
              "/dev/nvidia0",
              "/dev/nvidia-modeset",
              "/dev/dri/renderD128"
            ]
          '';
        };
        onBoot = "ignore";
        onShutdown = "shutdown";
        hooks = {
          qemu = {
            "gpuswitch" = pkgs.writeShellScript "gpuswitch-hook" ''
              readonly GUEST_NAME="$1"
              readonly HOOK_NAME="$2"
              readonly STATE_NAME="$3"

              start_hook() {
                systemctl --user --machine=${userdata.username}@ stop swaync # TEMPORARY FIX
                systemctl stop nvidia-powerd
                rmmod -f nvidia_drm
                rmmod nvidia_uvm
                rmmod nvidia_modeset
                rmmod nvidia
                modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1
                /run/current-system/sw/bin/virsh nodedev-detach pci_0000_01_00_0
                systemctl --user --machine=${userdata.username}@ start swaync # TEMPORARY FIX
              }

              revert_hook() {
                /run/current-system/sw/bin/virsh nodedev-reattach pci_0000_01_00_0
                rmmod vfio_pci vfio_pci_core vfio_iommu_type1
                modprobe -i nvidia
                modprobe -i nvidia_uvm
                modprobe -i nvidia_modeset
                modprobe -i nvidia_drm
                systemctl restart nvidia-powerd
              }

              if [[ "$HOOK_NAME" == "prepare" && "$STATE_NAME" == "begin" ]]; then
                if [[ "$GUEST_NAME" == "win11" || "$GUEST_NAME" == "win10" ]]
                then
                  start_hook
                fi
              elif [[ "$HOOK_NAME" == "release" && "$STATE_NAME" == "end" ]]; then
                if [[ "$GUEST_NAME" == "win11" || "$GUEST_NAME" == "win10" ]]
                then
                  revert_hook
                fi
              fi
            '';
          };
        };
      };
      spiceUSBRedirection.enable = true;
    };

    services = {
      spice-vdagentd.enable = true;
    };

    users.users.${userdata.username} = {
      extraGroups = [ "libvirtd" ];
    };
  };
}
