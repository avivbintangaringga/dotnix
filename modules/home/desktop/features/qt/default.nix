{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.desktop.features.qt.enable = lib.mkEnableOption "QT";
  };

  config = lib.mkIf config.setup.desktop.features.qt.enable {
    # TODO
  };
}
