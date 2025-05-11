{ pkgs, ... }:
{
  users = {
    users.r7fx = {
      isNormalUser = true;
      initialPassword = "123";
      extraGroups = [ "wheel" ]; 
      packages = with pkgs; [
        tree
      ];
    };

    defaultUserShell = pkgs.zsh;
  };

  programs = {
    firefox.enable = true;
    hyprland.enable = true;

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
      fastfetch
      brightnessctl
      kdePackages.dolphin
      git
      gh
      rofi
      wofi
    ];

    shells = with pkgs; [
       zsh
    ];
  };
}
