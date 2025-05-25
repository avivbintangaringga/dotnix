{ lib, config, ... }:
{
  options = {
    setup.services.logind.enable = lib.mkEnableOption "Logind";
  };

  config = lib.mkIf config.setup.services.logind.enable {
    logind = {
      enable = true;
    };
  };
}
