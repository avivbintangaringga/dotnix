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
    ./services/mako
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
      kdePackages.dolphin
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
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
