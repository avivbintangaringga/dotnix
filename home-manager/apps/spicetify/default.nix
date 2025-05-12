{ spicePkgs, ... }:
{
  programs.spicetify = {
    enable = true;
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
