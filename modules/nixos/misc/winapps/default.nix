{
  lib,
  config,
  winapps-pkgs,
  ...
}:
{
  options = {
    setup.misc.winapps.enable = lib.mkEnableOption "WinApps";
  };

  config = lib.mkIf config.setup.misc.winapps.enable {
    environment.systemPackages = with winapps-pkgs; [
      winapps
      winapps-launcher
    ];
  };
}
