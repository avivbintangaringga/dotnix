{ pkgs, userdata, ... }:
{
  imports = [
    ./apps/firefox
    ./apps/aagl
    ./apps/git
    ./apps/hyprland
    ./apps/rofi
    ./apps/waybar
    ./apps/zsh
    ./services/cliphist
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
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
