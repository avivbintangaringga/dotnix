{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.gauntlet.homeManagerModules.default
  ];

  options = {
    setup.apps.gauntlet.enable = lib.mkEnableOption "Gauntlet";
  };

  config = lib.mkIf config.setup.apps.gauntlet.enable {
    programs.gauntlet = {
      enable = true;
      service.enable = true;
      config = {};
    };
  };
}
