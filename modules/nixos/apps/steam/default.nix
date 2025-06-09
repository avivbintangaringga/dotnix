{ lib, config, ... }:
{
  options = {
    setup.apps.steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf config.setup.apps.steam.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
    };
  };
}
