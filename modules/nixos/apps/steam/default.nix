{ lib, config, pkgs, ... }:
{
  options = {
    setup.apps.steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf config.setup.apps.steam.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraPackages = with pkgs; [
          gamescope
      ];
    };
  };
}
