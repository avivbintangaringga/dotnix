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
    supportedFilesystems = [ "ntfs" ];
  };

  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.steam.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

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
      gh
      neovim

      killall
      nvtopPackages.nvidia
      nvtopPackages.amd
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

  fileSystems."/media/DATA" = {
    device = "/dev/disk/by-uuid/9EF2F582F2F55F49";
    fsType = "ntfs-3g";
    options = [ "defaults" ];
  };

  fileSystems."/media/WINDOWS" = {
    device = "/dev/disk/by-uuid/567C114B7C112771";
    fsType = "ntfs-3g";
    options = [ "defaults" ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

