{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.gaming.mangohud.enable = lib.mkEnableOption "Mangohud";
  };

  config = lib.mkIf config.setup.apps.gaming.mangohud.enable {
    home.packages = with pkgs; [
      mangohud
    ];
  };
}
