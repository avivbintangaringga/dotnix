{ config, lib, pkgs, ... }:
{
 imports =
    [ 
      ./hardware-configuration.nix
      ../../users/r7fx
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

