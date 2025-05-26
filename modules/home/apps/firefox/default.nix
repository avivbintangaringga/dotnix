{ lib, config, ... }:
{
  options = {
    setup.apps.firefox.enable = lib.mkEnableOption "Firefox";
  };

  config = lib.mkIf config.setup.apps.firefox.enable {
    programs.firefox.enable = true;
  };
}
