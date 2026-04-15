{ lib, config, ... }:
{
  options = {
    setup.services.accounts-daemon.enable = lib.mkEnableOption "Accounts Daemon";
  };

  config = lib.mkIf config.setup.services.accounts-daemon.enable {
    services = {
      accounts-daemon = {
        enable = true;
      };
    };
  };
}
