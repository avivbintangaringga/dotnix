{
  inputs,
  den,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

  den.hosts.x86_64-linux.inferno = {
    users.r7fx = {};
  };

  den.aspects.inferno = {
    includes = (with den.batteries; [
      hostname
    ]) ++ (with den.aspects; [
      base
      sudo

      # Hardware
      bluetooth
      nvidia
      disable-cpu-boost

      appimage
      gvfs
      logind
      pipewire
      printing
      power-profiles-daemon
      upower
    ]);

    nixos = { pkgs, lib, ... }: {
      imports = [
        ./_hardware-configuration.nix
        inputs.hardware.nixosModules.asus-fa506ic
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
          systemd-boot = {
            enable = true;
          };
          efi = {
            canTouchEfiVariables = true;
          };
          timeout = 0;
        };

        initrd = {
          systemd.enable = true;
          compressor = "zstd";
          kernelModules = [
            "snd-seq"

            # "vfio_pci"
            # "vfio"
            # "vfio_iommu_type1"

            # "nvidia"
            # "nvidia_modeset"
            # "nvidia_uvm"
            # "nvidia_drm"
          ];

        };

        kernelParams = [
          "nvidia-drm.modeset=1"
          "8250.nr_uarts=0"

          "clearcpuid=umip"
          # "amd_iommu=on"
          # "iommu=pt"
          # "vfio-pci.ids=10de:25a2,10de:2291"
        ];
      };

      hardware = {
        enableAllFirmware = true;
        amdgpu.initrd.enable = lib.mkForce false;
      };

      systemd.services = {
        NetworkManager-wait-online.enable = false;
      };

      fileSystems."/media/DATA" = {
        device = "/dev/disk/by-uuid/9EF2F582F2F55F49";
        fsType = "ntfs-3g";
        options = [ "defaults" ];
      };

      security.sudo = {
        extraRules = [
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
      };
    };
  };
}
