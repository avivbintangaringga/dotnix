{ lib, config, ... }:
{
  options = {
    setup.services.playerctld.enable = lib.mkEnableOption "Playerctld";
  };

  config = lib.mkIf config.setup.services.playerctld.enable {
    services.playerctld = {
      enable = true;
    };
  };
}
