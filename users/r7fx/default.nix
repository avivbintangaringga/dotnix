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
    #./configs
  ];

  users = {
    users.${userdata.username} = {
      isNormalUser = true;
      initialPassword = "123";
      extraGroups = [ "wheel" ]; 
      packages = with pkgs; [
        tree
      ];
    };
  };

  programs = {
    git.enable = true;
    firefox.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions = {
        enable = true;
      };
      histSize = 10000;

      shellAliases = {
        edit = "sudo vim /etc/nixos/";
        update = "sudo nixos-rebuild switch";
      };

      ohMyZsh = {
        enable = true;
        theme = "fino-time";
        plugins = [
          "git"
        ];
      };
    }; 
  };

  environment = {
    systemPackages = with pkgs; [
      kitty
      vim 
      wget
      brightnessctl
      kdePackages.dolphin
      home-manager
    ];

    shells = with pkgs; [
       zsh
    ];
  };
}
