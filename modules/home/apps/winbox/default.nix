{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.winbox.enable = lib.mkEnableOption "WinBox";
  };

  config = lib.mkIf config.setup.apps.winbox.enable {
    xdg.desktopEntries.winbox = {
      name = "WinBox";
      exec = "${pkgs.winbox4}/bin/WinBox";
      icon = ../../../../assets/icons/winbox.png;
      type = "Application";
      terminal = false;
    };
  };
}
