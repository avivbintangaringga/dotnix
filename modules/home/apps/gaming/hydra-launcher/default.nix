{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.gaming.hydra-launcher.enable = lib.mkEnableOption "Hydra Launcher";
  };

  config = lib.mkIf config.setup.apps.gaming.hydra-launcher.enable {
    home.packages = with pkgs; [
      hydralauncher
    ];
  };
}
