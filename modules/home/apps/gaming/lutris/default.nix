{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.gaming.lutris.enable = lib.mkEnableOption "Lutris";
  };

  config = lib.mkIf config.setup.apps.gaming.lutris.enable {
    programs.lutris = {
      enable = true;
    };
  };
}
