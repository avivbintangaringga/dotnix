{ inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./../../modules/nixos/import.nix
      inputs.hardware.nixosModules.asus-fa506ic
    ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 1;
    };
  };

  networking = {
    hostName = "asus-a15";
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

  fileSystems."/media/ARCH" = {
    device = "/dev/disk/by-uuid/a7b2e66e-5fd3-47df-97fc-468b710c0beb";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/media/ARCH-HOME" = {
    device = "/dev/disk/by-uuid/a7b2e66e-5fd3-47df-97fc-468b710c0beb";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
