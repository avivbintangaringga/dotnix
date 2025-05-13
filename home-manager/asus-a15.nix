{ pkgs, userdata, ... }:
{
  imports = [
    ./apps/firefox
    ./apps/git
    ./apps/hyprland
    ./apps/spicetify
    ./apps/rofi
    ./apps/waybar
    ./apps/zsh
    ./services/cliphist
    ./services/notification
    ./services/playerctld
  ];

  home = {
    username = userdata.username;
    homeDirectory = userdata.userpath;
    stateVersion = "24.11";
    packages = with pkgs; [
      fastfetch
      kitty
      neovim 
      wget
      brightnessctl
      vesktop
      discord

      lutris
      protonup-qt
      umu-launcher
      wine
      bottles
      mangohud
      heroic

      btop
      htop

      bitwarden

      grimblast
      oculante

      zip
      unzip
      p7zip
      unrar

      kdePackages.dolphin
      kdePackages.kio-admin
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
