{ inputs, lib, config, ... }:
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
    nix.settings = aagl.nixConfig;
    programs.anime-game-launcher.enable = true;
  };
}
