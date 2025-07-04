{ lib, config, ... }:
{
  options = {
    setup.services.upower.enable = lib.mkEnableOption "UPower";
  };

  config = lib.mkIf config.setup.services.upower.enable {
    services = {
      upower = {
        enable = true;
      };
    };
  };
}
