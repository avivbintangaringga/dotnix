{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.gaming.wine = lib.mkEnableOption "Wine";
  };

  config = lib.mkIf config.setup.apps.gaming.wine
  || config.setup.apps.gaming.all {
    home.packages = with pkgs; [
      wine
      wineWowPackages.stable
      winetricks
    ];
  };
}
