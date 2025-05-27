{
  lib,
  config,
  ...
}:
{
  options = {
    setup.misc.waydroid.enable = lib.mkEnableOption "Waydroid";
  };

  config = lib.mkIf config.setup.misc.waydroid.enable {
    virtualisation.waydroid.enable = true;
  };
}
