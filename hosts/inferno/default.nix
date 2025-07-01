{
  mylib,
  inputs,
  userdata,
  pkgs,
  ...
}:
let
  inherit (mylib) enabled disabled;
in
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos/import.nix
    inputs.hardware.nixosModules.asus-fa506ic
  ];

  setup = {
    apps = {
      aagl = disabled;
      steam = enabled;
      winbox = enabled;
    };

    cli-apps = {
      adb = enabled;
      archive-tools = enabled;
      git = enabled;
      helix = enabled;
      home-manager = enabled;
      misc = enabled;
      monitoring = enabled;
      nh = enabled;
      nvim = enabled;
      nix-alien = enabled;
    };

    desktop = {
      hyprland = enabled;
    };

    fonts = {
      basic = enabled;
      ms = enabled;
      apple = enabled;
      nerd = enabled;
    };

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
    };

    misc = {
      gaming = enabled;
      plymouth = enabled;
      waydroid = disabled;
      virt-manager = enabled;
      vmware = enabled;
    };

    services = {
      auto-cpufreq = {
        enable = true;
        turbo = false;
      };

      gvfs = enabled;
      logind = enabled;
      pipewire = enabled;
      tuigreet = enabled;
      upower = enabled;
    };
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 1;
    };

    initrd = {
      kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"

        # "nvidia"
        # "nvidia_modeset"
        # "nvidia_drm"
        # "nvidia_uvm"
      ];
    };

    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=10de:25a2,10de:2291"
    ];
  };

  security = {
    sudo = {
      enable = true;
      extraRules = [
        {
          commands = [
            {
              command = "${pkgs.kmod}/bin/modprobe";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.kmod}/bin/rmmod";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.systemd}/bin/systemctl";
              options = [ "NOPASSWD" ];
            }
          ];
          groups = [ "wheel" ];
        }
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/scream 0660 ${userdata.username} qemu-libvirtd -"
    "f /dev/shm/looking-glass 0660 ${userdata.username} qemu-libvirtd -"
  ];

  networking = {
    hostName = "inferno";
  };

  fileSystems."/media/DATA" = {
    device = "/dev/disk/by-uuid/9EF2F582F2F55F49";
    fsType = "ntfs-3g";
    options = [ "defaults" ];
  };

  fileSystems."/media/WINDOWS" = {
    device = "/dev/disk/by-uuid/567C114B7C112771";
    fsType = "ntfs-3g";
    options = [ "defaults" ];
  };

  fileSystems."/media/ARCH" = {
    device = "/dev/disk/by-uuid/a7b2e66e-5fd3-47df-97fc-468b710c0beb";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/media/ARCH-HOME" = {
    device = "/dev/disk/by-uuid/a7b2e66e-5fd3-47df-97fc-468b710c0beb";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
