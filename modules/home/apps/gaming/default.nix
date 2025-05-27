{ lib, config, ... }:
{
  options = {
    setup.apps.gaming.all.enable = lib.mkEnableOption "Gaming Apps";
  };

  config = lib.mkIf config.setup.apps.gaming.all.enable {
    setup.apps.gaming = {
      heroic.enable = true;
      lutris.enable = true;
      mangohud.enable = true;
      protonup-qt.enable = true;
      wine.enable = true;
    };
  };
}
