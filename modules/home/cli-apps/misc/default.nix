{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.cli-apps.misc.enable = lib.mkEnableOption "Miscellaneous CLI Apps";
  };

  config = lib.mkIf config.setup.cli-apps.misc.enable {
    home.packages = with pkgs; [
      rclone
      wev
      cava

      kanidm_1_8

      lsof
      gnumake

      tailwindcss_4
      watchman

      yt-dlp
    ];
  };
}
