{ inputs, pkgs, userdata, ... }:
{
  imports = [
    ./apps/firefox
    ./apps/git
    ./apps/hyprland
    ./apps/kitty
    ./apps/neovim
    ./apps/obs-studio
    ./apps/spicetify
    ./apps/rofi
    ./apps/waybar
    ./apps/yazi
    ./apps/zen-browser
    ./apps/zsh
    ./services/cliphist
    ./services/hyprpolkitagent
    ./services/notification
    ./services/playerctld

    inputs.spicetify-nix.homeManagerModules.spicetify
    inputs.zen-browser.homeModules.beta
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
      nemo

      wev
      qt5-wayland
      qt6-wayland
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
