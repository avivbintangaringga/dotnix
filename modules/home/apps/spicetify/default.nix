{ lib, config, inputs, ... }:
{
  options = {
    setup.apps.spicetify.enable = lib.mkEnableOption "Spicetify";
  };

  config = lib.mkIf config.setup.apps.spicetify.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with inputs.spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        betterGenres
        sectionMarker
        fullAppDisplay
        powerBar
        songStats
      ];
      theme = inputs.spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
