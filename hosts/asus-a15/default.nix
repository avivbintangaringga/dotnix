{ config, lib, pkgs, userdata, ... }:
{
 imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  programs.zsh.enable = true;
  users = {
    users.${userdata.username} = {
      isNormalUser = true;
      initialPassword = "123";
      extraGroups = [ "wheel" ]; 
      packages = with pkgs; [
        tree
      ];
      shell = pkgs.zsh;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      home-manager
    ];

    shells = with pkgs; [
       zsh
    ];
  };

  networking = {
    hostName = "nixos"; 
    networkmanager.enable = true;  
  };

  time.timeZone = "Asia/Jakarta";

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    libinput.enable = true;
  };

  system.stateVersion = "24.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

