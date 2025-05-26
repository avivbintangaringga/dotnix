{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.gaming.wine.enable = lib.mkEnableOption "Wine";
  };

  config = lib.mkIf config.setup.apps.gaming.wine.enable {
    home.packages = with pkgs; [
      wineWowPackages.stable
      winetricks
    ];
  };
}
