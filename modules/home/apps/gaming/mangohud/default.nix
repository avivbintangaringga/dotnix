{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.gaming.mangohud = lib.mkEnableOption "Mangohud";
  };

  config = lib.mkIf config.setup.apps.gaming.mangohud
  || config.setup.apps.gaming.all {
    home.packages = with pkgs; [
      mangohud
    ];
  };
}
