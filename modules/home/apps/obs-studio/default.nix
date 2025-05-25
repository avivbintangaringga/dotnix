{ lib, config, options, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.setup.apps.obs-studio;
in
{
  options.setup.apps.obs-studio.enable = mkEnableOption "Enable OBS Studio";
  programs.obs-studio = {
    enable = cfg.enable;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };
}
