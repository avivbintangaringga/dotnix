{
  den,
  dotnix,
  inputs,
  ...
}:
{
  den = {
    aspects.inferno = {
      includes =
        (with den.batteries; [
          hostname
        ])
        ++ (with dotnix; [
          base

          # Hardware
          bluetooth
          nvidia
          # disable-cpu-boost
          v4l2loopback
          # cpuid-fault-emulation

          appimage
          nix-ld
          # nix-alien
          gvfs
          fuse
          logind
          pipewire
          printing
          avahi
          power-profiles-daemon
          upower
        ]);

      nixos = { pkgs, ... }: {
        boot = {
          initrd = {
            compressor = "zstd";
            kernelModules = [
              "snd-seq"

              # "vfio_pci"
              # "vfio"
              # "vfio_iommu_type1"

              "nvidia"
              "nvidia_modeset"
              "nvidia_uvm"
              "nvidia_drm"
            ];
          };
          kernelPackages = pkgs.linuxPackages_latest;
          kernelParams = [
            # "nvidia-drm.modeset=1"
            "8250.nr_uarts=0"

            "amd_iommu=on"
            "iommu=pt"
            "vfio-pci.ids=10de:25a2,10de:2291"
            # "rd.driver.pre=vfio-pci"
            "usbcore.autosuspend=-1"
          ];
          loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
            timeout = 0;
          };
        };
        fileSystems = {
          "/home/r7fx/VM-SHARED/DATA" = {
            depends = [ "/media/DATA" ];
            device = "/media/DATA";
            fsType = "none";
            options = [
              "bind"
              "x-gvfs-hide"
              "nofail"
            ];
          };
          "/media/DATA" = {
            device = "/dev/disk/by-uuid/9EF2F582F2F55F49";
            fsType = "ntfs-3g";
            options = [
              "defaults"
              "nofail"
              "x-systemd.device-timeout=5s"
              "uid=1000"
              "gid=100"
            ];
          };
        };
        hardware.enableAllFirmware = true;
        imports = [
          ./_hardware.nix
          inputs.hardware.nixosModules.asus-fa506ic
        ];
        security.sudo.extraRules = [
          {
            # For VFIO script
            commands = [
              {
                command = "/run/current-system/sw/bin/systemctl";
                options = [ "NOPASSWD" ];
              }
              {
                command = "/run/current-system/sw/bin/rmmod";
                options = [ "NOPASSWD" ];
              }
              {
                command = "/run/current-system/sw/bin/modprobe";
                options = [ "NOPASSWD" ];
              }
              {
                command = "/run/current-system/sw/bin/virsh";
                options = [ "NOPASSWD" ];
              }
              {
                command = "/run/current-system/sw/bin/pkill";
                options = [ "NOPASSWD" ];
              }
              {
                command = "/run/current-system/sw/bin/efibootmgr";
                options = [ "NOPASSWD" ];
              }
            ];
            groups = [ "wheel" ];
          }
        ];
        systemd.services.NetworkManager-wait-online.enable = false;
      };
    };
    hosts.x86_64-linux.inferno.users.r7fx = { };
  };
  imports = [ inputs.den.flakeModule ];
}
