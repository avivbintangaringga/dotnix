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
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      config = null;
      settings = null;
    };
  };
}
