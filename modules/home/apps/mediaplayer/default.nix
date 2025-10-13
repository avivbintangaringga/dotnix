{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.mediaplayer.enable = lib.mkEnableOption "Media Player";
  };

  config = lib.mkIf config.setup.apps.mediaplayer.enable {
    home.packages = with pkgs; [
      # oculante
      kdePackages.gwenview
      vlc
    ];
  };
}
