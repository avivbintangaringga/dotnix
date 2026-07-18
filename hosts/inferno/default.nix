{
  mylib,
  lib,
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
      kdeconnect = disabled;
      nautilus = enabled;
      steam = enabled;
      winbox = enabled;
      valent = enabled;
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
      nix-alien = disabled;
      zsh = enabled;
    };

    desktop = {
      hyprland = disabled;
      kde = disabled;
      mango = disabled;
      niri = enabled;
      features = {
        qt = enabled;
      };
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
      cpuid-fault-emulation = enabled;
      docker = enabled;
      gaming = enabled;
      nix-ld = enabled;
      plymouth = disabled;
      waydroid = enabled;
      virt-manager = enabled;
      vmware = disabled;
    };

    services = {
      accounts-daemon = enabled;
      auto-cpufreq = {
        enable = false;
        turbo = true;
      };
      cloudflare-warp = enabled;
      dankgreet = disabled;
      disable-cpu-boost = enabled;
      flatpak = enabled;
      gvfs = enabled;
      logind = enabled;
      lsfg-vk = enabled;
      nfs = disabled;
      noctalia-greeter = enabled;
      ollama = disabled;
      pipewire = enabled;
      power-profiles-daemon = enabled;
      printing = enabled;
      samba = disabled;
      tuigreet = disabled;
      upower = enabled;
    };
  };

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
          {
            command = "/run/current-system/sw/bin/efibootmgr";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }
    ];
  };

  hardware = {
    enableAllFirmware = true;
    amdgpu.initrd.enable = lib.mkForce false;
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/scream 0660 ${userdata.username} qemu-libvirtd -"
    "f /dev/shm/looking-glass 0660 ${userdata.username} qemu-libvirtd -"
  ];

  systemd.services = {
    NetworkManager-wait-online.enable = false;
  };

  networking = {
    hostName = "inferno";
  };

  users.users.${userdata.username} = {
    extraGroups = [ "networkmanager" ];
  };

  fileSystems."/media/DATA" = {
    device = "/dev/disk/by-uuid/9EF2F582F2F55F49";
    fsType = "ntfs-3g";
    options = [ "defaults" ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
