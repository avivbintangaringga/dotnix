{
  inputs,
  lib,
  config,
  ...
}:
let
  aagl = inputs.aagl;
in
{
  imports = [
    aagl.nixosModules.default
  ];

  options = {
    setup.apps.aagl.enable = lib.mkEnableOption "An Anime Game Launcher";
  };

  config = lib.mkIf config.setup.apps.aagl.enable {
    programs.anime-game-launcher.enable = true;
    nix.settings = {
      substituters = [ "https://ezkea.cachix.org" ];
      trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
    };
  };
}
