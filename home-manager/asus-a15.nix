{ pkgs, userdata, ... }:
{
  imports = [
    ./apps/firefox
    ./apps/git
    ./apps/hyprland
    ./apps/zsh
    ./services/cliphist
  ];

  home = {
    username = userdata.username;
    homeDirectory = userdata.userpath;
    stateVersion = "24.11";
    packages = with pkgs; [
      gh
      rofi
      wofi
      fastfetch
      kitty
      neovim 
      wget
      brightnessctl
      kdePackages.dolphin
    ];
  };
}
