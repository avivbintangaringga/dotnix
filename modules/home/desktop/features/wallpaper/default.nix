{ pkgs, lib, config, userdata, ... }:
{
  options = {
    setup.desktop.features.wallpaper.enable = lib.mkEnableOption "Wallpaper";
  };

  config = lib.mkIf config.setup.desktop.features.wallpaper.enable {
    services.swww = {
      enable = true;
    };

    home = {
      packages = with pkgs; [
        pywal16
        imagemagick
      ];

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
  };
}
