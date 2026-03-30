{
  flake.modules.nixosModules.inferno = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/705b0b03-13cb-4f9f-958d-9cf9d9a8889e";
      fsType = "btrfs";
      options = [ "subvol=@nixos" ];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/705b0b03-13cb-4f9f-958d-9cf9d9a8889e";
      fsType = "btrfs";
      options = [ "subvol=@nixos-home" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    fileSystems."/media/DATA" = {
      device = "/dev/disk/by-uuid/9EF2F582F2F55F49";
      fsType = "ntfs-3g";
      options = [ "defaults" ];
    };

    swapDevices = [ ];
  };
}
