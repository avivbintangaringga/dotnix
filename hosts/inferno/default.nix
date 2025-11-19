{
  mylib,
  inputs,
  userdata,
  ...
}:
let
  inherit (mylib) enabled disabled;
in
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos/import.nix
    ./../../overlays/import.nix
    inputs.hardware.nixosModules.asus-fa506ic
  ];

  system.replaceDependencies.replacements = [
    # {
    #   oldDependency = pkgs.mesa;
    #   newDependency = pkgs.mesa-25-1-7;
    # }
  ];

  # services = {
  #    xserver = {
  #     enable = true;
  #     videoDrivers = [
  #       "amdgpu"
  #       "nvidia"
  #     ];
  #   };
  # };

  setup = {
    apps = {
      nautilus = enabled;
      steam = enabled;
      winbox = disabled;
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
      hyprland = disabled;
      kde = disabled;
      mango = enabled;
      niri = enabled;
    };

    fonts = {
      basic = enabled;
      ms = enabled;
      apple = disabled;
      nerd = enabled;
    };

    hardware = {
      bluetooth = enabled;
      nvidia = enabled;
    };

    misc = {
      appimage = enabled;
      docker = enabled;
      gaming = enabled;
      nix-ld = enabled;
      plymouth = enabled;
      waydroid = enabled;
      virt-manager = enabled;
      vmware = disabled;
    };

    services = {
      auto-cpufreq = {
        enable = true;
        turbo = false;
      };
      cloudflare-warp = enabled;
      flatpak = enabled;
      gvfs = enabled;
      logind = enabled;
      lsfg-vk = enabled;
      nfs = disabled;
      pipewire = enabled;
      samba = enabled;
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
        "snd-seq"

        # "vfio_pci"
        # "vfio"
        # "vfio_iommu_type1"

        "nvidia"
        "nvidia_modeset"
        "nvidia_drm"
        "nvidia_uvm"
      ];
    };

    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=10de:25a2,10de:2291"
    ];
  };

  security.sudo = {
    enable = true;
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
        ];
        groups = [ "wheel" ];
      }
    ];
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

  system.stateVersion = "24.11"; # Did you read the comment?
}
