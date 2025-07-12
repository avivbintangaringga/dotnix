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
                systemctl stop nvidia-powerd
                rmmod -f nvidia_drm
                rmmod nvidia_uvm
                rmmod nvidia_modeset
                rmmod nvidia
                modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1
                /run/current-system/sw/bin/virsh nodedev-detach pci_0000_01_00_0
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
                start_hook
              elif [[ "$HOOK_NAME" == "release" && "$STATE_NAME" == "end" ]]; then
                revert_hook
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
