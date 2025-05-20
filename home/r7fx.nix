{ inputs, pkgs, userdata, ... }:
{
  imports = [
    ./apps/firefox
    ./apps/git
    ./apps/hellwall
    ./apps/hyprland
    ./apps/kitty
    #./apps/neovim
    ./apps/nh
    ./apps/nixvim
    ./apps/obs-studio
    ./apps/spicetify
    ./apps/rofi
    ./apps/waybar
    ./apps/yazi
    ./apps/zen-browser
    ./apps/zsh
    ./services/blueman
    ./services/cliphist
    ./services/hyprpaper
    ./services/hyprpolkitagent
    ./services/swaync
    ./services/swww
    ./services/playerctld

    inputs.spicetify-nix.homeManagerModules.spicetify
    inputs.zen-browser.homeModules.beta
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home = {
    username = userdata.username;
    homeDirectory = userdata.userpath;
    stateVersion = "24.11";
    packages = with pkgs; [
      fastfetch
      wget
      brightnessctl
      discord

      protonup-qt
      wineWowPackages.stable
      winetricks
      mangohud
      heroic

      btop
      htop
      btdu

      bitwarden

      zotero
      wpsoffice

      grimblast
      oculante
      libnotify

      zip
      unzip
      p7zip
      unrar

      vlc
      nemo-with-extensions

      speedtest-cli
      wev
      hellwal
      networkmanagerapplet
      pywal16
      imagemagick
      wallust

      scrcpy
      qtscrcpy
    ];

    pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk  = {
        enable = true;
      };
      hyprcursor = {
        enable = true;
        size = 24;
      };
    };

    file = {
      "${userdata.userpath}/.wallpapers" = {
        source = ./wallpapers;
	recursive = true;
      };

      "${userdata.userpath}/.scripts" = {
        source = ./scripts;
	executable = true;
	recursive = true;
      };
    };
  };

  xdg = {
    configFile = {
      #"hellwal/templates/waybar.css" = {
      #  source = ./hellwal/waybar.css;
      #};
    };
  };

  #fonts.fontconfig = {
  #  enable = true;
  #  defaultFonts = with pkgs; {
  #    serif = 
  #  };
  #};

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };


  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
