{ config, lib, pkgs, userdata, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

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
    supportedFilesystems = [ "ntfs" ];
    plymouth = {
      enable = true;
      theme = "circle_hud";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
           selected_themes = [ "circle_hud" ];
	})
      ];
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quite"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    lato
    open-sans
    roboto
    inter
    corefonts
    vistafonts
  ];

  programs.adb.enable = true;
  programs.winbox = {
    enable = true;
    openFirewall = true;
    package = pkgs.winbox4;
  };
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
  programs.gamescope = {
    enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  users = {
    users.${userdata.username} = {
      isNormalUser = true;
      initialPassword = "123";
      extraGroups = [ "wheel" "adbusers" ]; 
      packages = with pkgs; [
        tree
      ];
      shell = pkgs.zsh;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      home-manager
      gh

      pavucontrol
      greetd.tuigreet

      killall
      nvtopPackages.nvidia
      nvtopPackages.amd

      powertop
      nixd
      nil
    ];

    shells = with pkgs; [
       zsh
    ];
  };

  networking = {
    hostName = "asus-a15"; 
    networkmanager.enable = true;  
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      prime = {
	nvidiaBusId = lib.mkForce "PCI:1:0:0";
	amdgpuBusId = lib.mkForce "PCI:6:0:0";
      };
    };
  };

  time.timeZone = "Asia/Jakarta";

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    libinput.enable = true;

    upower = {
      enable = true;
    };

    blueman = {
      enable = true;
    };

    #tlp = {
    #  enable = true;
    #  settings = {
    #    CPU_BOOST_ON_AC = 0;
    #    CPU_BOOST_ON_BAT = 0;
    #  };
    #};

    preload.enable = true;

    auto-cpufreq = let
      turbo = "never";
    in {
      enable = true;
      settings = {
        charger = {
          inherit turbo;
          gorvernor = "performance";
        };
        battery = {
          inherit turbo;
          governor = "powersave";
          scaling_max_freq = 1500000;
          platform_profile = "quiet";
          energy_per_bias = "balance_power";
        };
      };
    };

    gvfs = {
      enable = true;
    };

    greetd = let
      session = "${pkgs.hyprland}/bin/Hyprland";
      tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    in {
      enable = true;
      settings = {
        initial_session = {
           command = "${session}";
	   user = userdata.username;
	};
	default_session = {
           command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
	   user = "greeter";
	};
      };
    };

    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend";
    };
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

  system.userActivationScripts = {
    copy-fonts-local-share = {
      text = ''
        rm -rf ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
        cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        cp ${pkgs.vistafonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 544 ~/.local/share/fonts
        chmod 444 ~/.local/share/fonts/*
      '';
    };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

