{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.misc.waydroid.enable = lib.mkEnableOption "Waydroid";
  };

  config = lib.mkIf config.setup.misc.waydroid.enable {
    virtualisation.waydroid.enable = true;
    networking.nftables.enable = true;
    environment.systemPackages = with pkgs;[
      waydroid-helper
      fakeroot
    ];
  };
}
