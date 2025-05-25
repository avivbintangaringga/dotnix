{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.gaming.protonup-qt.enable = lib.mkEnableOption "ProtonUp-QT";
  };

  config = lib.mkIf config.setup.apps.gaming.protonup-qt.enable {
    home.packages = with pkgs; [
      protonup-qt
    ];
  };
}
