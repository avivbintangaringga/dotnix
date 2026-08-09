{
  den,
  dotnix,
  inputs,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

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
          disable-cpu-boost
          # cpuid-fault-emulation

          appimage
          nix-ld
          # nix-alien
          gvfs
          logind
          pipewire
          printing
          power-profiles-daemon
          upower
        ]);

      nixos = { pkgs, ... }: {
        imports = [
          ./_hardware.nix
          inputs.hardware.nixosModules.asus-fa506ic
        ];
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
            systemd.enable = true;

          };
          kernelPackages = pkgs.linuxPackages_latest;
          kernelParams = [
            # "nvidia-drm.modeset=1"
            "8250.nr_uarts=0"

            "amd_iommu=on"
            "iommu=pt"
            "vfio-pci.ids=10de:25a2,10de:2291"
            # "rd.driver.pre=vfio-pci"
          ];
          loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
            timeout = 0;
          };
        };
        fileSystems."/media/DATA" = {
          options = [ "defaults" ];
          device = "/dev/disk/by-uuid/9EF2F582F2F55F49";
          fsType = "ntfs-3g";
        };
        hardware.enableAllFirmware = true;
        security.sudo.extraRules = [
          {
            # For VFIO script
            commands = [
              {
                options = [ "NOPASSWD" ];
                command = "/run/current-system/sw/bin/systemctl";
              }
              {
                options = [ "NOPASSWD" ];
                command = "/run/current-system/sw/bin/rmmod";
              }
              {
                options = [ "NOPASSWD" ];
                command = "/run/current-system/sw/bin/modprobe";
              }
              {
                options = [ "NOPASSWD" ];
                command = "/run/current-system/sw/bin/virsh";
              }
              {
                options = [ "NOPASSWD" ];
                command = "/run/current-system/sw/bin/pkill";
              }
              {
                options = [ "NOPASSWD" ];
                command = "/run/current-system/sw/bin/efibootmgr";
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
}
