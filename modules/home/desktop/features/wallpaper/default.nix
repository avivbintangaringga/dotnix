{
  pkgs,
  lib,
  config,
  userdata,
  ...
}:
{
  options = {
    setup.desktop.features.wallpaper.enable = lib.mkEnableOption "Wallpaper";
  };

  config = lib.mkIf config.setup.desktop.features.wallpaper.enable {
    # services.swww = {
    #   enable = false;
    # };

    home = {
      packages = with pkgs; [
        swww
        pywal16
        imagemagick
      ];

      file = {
        "${userdata.userpath}/.wallpapers" = {
          enable = true;
          source = ../../../../../assets/wallpapers;
          recursive = true;
          force = true;
        };

        "${userdata.userpath}/.scripts" = {
          enable = true;
          source = ./scripts;
          executable = true;
          recursive = true;
        };
      };
    };
  };
}
