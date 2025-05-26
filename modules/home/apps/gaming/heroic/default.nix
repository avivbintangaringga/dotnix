{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.gaming.heroic.enable = lib.mkEnableOption "Heroic Launcher";
  };

  config = lib.mkIf config.setup.apps.gaming.heroic.enable {
    home.packages = with pkgs; [
      heroic
    ];
  };
}
