{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.mango.nixosModules.mango
  ];

  options = {
    setup.desktop.mango.enable = lib.mkEnableOption "MangoWC";
  };

  config = lib.mkIf config.setup.desktop.mango.enable {
    programs.mango = {
      enable = true;
    };
  };
}
