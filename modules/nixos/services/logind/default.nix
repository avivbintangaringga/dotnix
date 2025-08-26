{ lib, config, ... }:
{
  options = {
    setup.services.logind.enable = lib.mkEnableOption "Logind";
  };

  config = lib.mkIf config.setup.services.logind.enable {
    services = {
      logind = {
        settings = {
          Login = {
            HandlePowerKey = "suspend";
            HandleLidSwitch = "suspend";
          };
        };
      };
    };
  };
}
