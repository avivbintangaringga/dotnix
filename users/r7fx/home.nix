{ pkgs, ... }:
let
  userdata = rec {
     username = "r7fx";
     userpath = "/home/" + username;
     fullname = "R7FX";
     email = "avivbintangaringga90@gmail.com";
  };
in
{
  imports = [
    ./configs
  ];

  home = {
    username = userdata.username;
    homeDirectory = userdata.userpath;
    stateVersion = "24.11";
    packages = with pkgs; [
      gh
      git
      rofi
      wofi
      fastfetch
    ];
  };

  services = {
    cliphist.enable = true;
  };

  programs.git = {
    enable = true;
    userName = userdata.username;
    userEmail = userdata.email;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.5;
	blur = true;
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };
}

