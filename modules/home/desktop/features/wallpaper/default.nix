{ pkgs, lib, config, userdata, ... }:
{
  options = {
    setup.desktop.features.wallpaper.enable = lib.mkEnableOption "Wallpaper";
  };

  config = lib.mkIf config.setup.desktop.features.wallpaper.enable {
    home.packages = with pkgs; [
      pywal16
      imagemagick
    ];

    services.swww = {
      enable = true;
    };

    file = {
      "${userdata.userpath}/.wallpapers" = {
        source = ./wallpapers;
	      recursive = true;
      };

      "${userdata.userpath}/.scripts" = {
        source = ./scripts;
	      executable = true;
	      recursive = true;
      };
    };
  };
}
