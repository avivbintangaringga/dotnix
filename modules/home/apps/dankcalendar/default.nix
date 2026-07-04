{
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.dankcalendar.homeModules.default
  ];

  options = {
    setup.apps.dankcalendar.enable = lib.mkEnableOption "Zen Browser";
  };

  config = lib.mkIf config.setup.apps.dankcalendar.enable {
    programs.dank-calendar = {
      enable = true;
    };
  };
}
