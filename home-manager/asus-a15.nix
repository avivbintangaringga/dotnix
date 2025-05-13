{ pkgs, userdata, ... }:
{
  imports = [
    ./apps/firefox
    ./apps/git
    ./apps/hyprland
    ./apps/kitty
    ./apps/neovim
    ./apps/spicetify
    ./apps/rofi
    ./apps/waybar
    ./apps/yazi
    ./apps/zen-browser
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

      nemo
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
