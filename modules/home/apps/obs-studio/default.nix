{ lib, config, pkgs, ... }:
{
  options.setup.apps.obs-studio.enable = lib.mkEnableOption "OBS Studio";
  config = lib.mkIf config.setup.apps.obs-studio.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
  };
}
