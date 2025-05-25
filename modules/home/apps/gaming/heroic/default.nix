{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.gaming.heroic = lib.mkEnableOption "Heroic Launcher";
  };

  config = lib.mkIf config.setup.apps.gaming.heroic
  || config.setup.apps.gaming.all {
    home.packages = with pkgs; [
      heroic
    ];
  };
}
