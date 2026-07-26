{
  inputs,
  ...
}:
{
  den.aspects.spotify = {
    homeManager = { pkgs, ...}:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [
        inputs.spicetify-nix.homeManagerModules.default
      ];

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
      };
    };
  };
}
