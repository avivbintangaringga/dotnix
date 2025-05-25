{ lib, config, options, spicePkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.setup.apps.spicetify;
in
{
  options.setup.apps.spicetify.enable = mkEnableOption "Enable Spicetify";
  programs.spicetify = {
    enable = cfg.enable;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
      betterGenres
      sectionMarker
      fullAppDisplay
      powerBar
      songStats
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
