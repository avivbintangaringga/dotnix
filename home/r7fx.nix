{ inputs, pkgs, userdata, ... }:
{
  imports = [
    ./apps/firefox
    ./apps/git
    ./apps/hyprland
    ./apps/kitty
    #./apps/neovim
    ./apps/nixvim
    ./apps/obs-studio
    ./apps/spicetify
    ./apps/rofi
    ./apps/waybar
    ./apps/yazi
    ./apps/zen-browser
    ./apps/zsh
    ./services/cliphist
    ./services/hyprpaper
    ./services/hyprpolkitagent
    ./services/swaync
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
      vesktop
      discord

      protonup-qt
      wineWowPackages.stable
      winetricks
      mangohud
      heroic

      btop
      htop

      bitwarden

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
    ];

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

  #fonts.fontconfig = {
  #  enable = true;
  #  defaultFonts = with pkgs; {
  #    serif = 
  #  };
  #};

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
