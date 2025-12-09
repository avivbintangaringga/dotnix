{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  options = {
    setup.apps.spicetify.enable = lib.mkEnableOption "Spicetify";
  };

  config = lib.mkIf config.setup.apps.spicetify.enable {
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
  };
}
