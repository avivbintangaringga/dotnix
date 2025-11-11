{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.desktop.features.cursor.enable = lib.mkEnableOption "Cursor";
  };

  config = lib.mkIf config.setup.desktop.features.cursor.enable {
    home = {
      pointerCursor = {
        enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
        gtk = {
          enable = true;
        };
        hyprcursor = {
          enable = config.setup.desktop.hyprland.enable;
          size = 24;
        };
      };
    };
  };
}
