{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  options = {
    setup.desktop.niri.enable = lib.mkEnableOption "Niri WM";
  };

  config = lib.mkIf config.setup.desktop.niri.enable {
    setup.desktop.features = {
      cursor.enable = true;
      gtk.enable = true;
      wallpaper.enable = true;
      dankmaterialshell.enable = true;
    };

    # services.polkit-gnome.enable = true;

    home.file = {
      ".config/niri/config.kdl" = {
        source = ./config/config.kdl;
      };

      ".config/niri/dms-overrides.kdl" = {
        source = ./config/dms-overrides.kdl;
      };
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      config = null;
      settings = null;
    };
  };
}
