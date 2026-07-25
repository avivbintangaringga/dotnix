{
  lib,
  config,
  inputs,
  userdata,
  pkgs,
  ...
}:
{
  imports = [
  ];

  options = {
    setup.services.noctalia-greeter.enable = lib.mkEnableOption "Dank Material Shell Greeter";
  };

  config = lib.mkIf config.setup.services.noctalia-greeter.enable {
  };
}
