{
  myPkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.gaming.faugus-launcher.enable = lib.mkEnableOption "Faugus Launcher";
  };

  config = lib.mkIf config.setup.apps.gaming.faugus-launcher.enable {
    home.packages = with myPkgs; [
      faugus-launcher
    ];
  };
}
