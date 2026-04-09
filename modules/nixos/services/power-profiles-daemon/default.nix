{ lib, config, ... }:
{
  options = {
    setup.services.power-profiles-daemon.enable = lib.mkEnableOption "Power Profiles Daemon";
  };

  config = lib.mkIf config.setup.services.power-profiles-daemon.enable {
    services = {
      power-profiles-daemon = {
        enable = true;
      };
    };
  };
}
