{
  lib,
  config,
  ...
}:
{
  options = {
    setup.desktop.features.swayosd.enable = lib.mkEnableOption "SwayOSD";
  };

  config = lib.mkIf config.setup.desktop.features.swayosd.enable {
    services.swayosd = {
      enable = true;
    };
  };
}
