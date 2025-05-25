{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.gaming.protonup-qt = lib.mkEnableOption "ProtonUp-QT";
  };

  config = lib.mkIf config.setup.apps.gaming.protonup-qt
  || config.setup.apps.gaming.all {
    home.packages = with pkgs; [
      protonup-qt
    ];
  };
}
