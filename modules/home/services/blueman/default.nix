{ lib, config, ... }:
{
  options = {
    setup.services.blueman.enable = lib.mkEnableOption "Blueman";
  };

  config = lib.mkIf config.setup.services.blueman.enable {
    services.blueman-applet = {
      enable = true;
    };
  };
}
