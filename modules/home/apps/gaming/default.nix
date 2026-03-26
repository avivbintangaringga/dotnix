{ lib, config, pkgs, ... }:
{
  options = {
    setup.apps.gaming.all.enable = lib.mkEnableOption "Gaming Apps";
  };

  config = lib.mkIf config.setup.apps.gaming.all.enable {
    home.packages = with pkgs; [
      goverlay
    ];

    setup.apps.gaming = {
      bottles.enable = false;
      faugus-launcher.enable = true;
      heroic.enable = false;
      lutris.enable = false;
      mangohud.enable = true;
      protonplus.enable = true;
      wine.enable = true;
    };
  };
}
