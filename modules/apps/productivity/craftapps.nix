{
  inputs,
  ...
}:
{
  dotnix.craftapps = {
    homeManager = {
      imports = [
        inputs.craftapps.homeManagerModules.default
      ];

      programs.craftapps = {
        apps = {
          cadcraft.enable = true;
          deckcraft.enable = true;
          designcraft.enable = true;
          effectcraft.enable = true;
          figcraft.enable = true;
          filmcraft.enable = true;
          gridcraft.enable = true;
          lightcraft.enable = true;
          pdfcraft.enable = true;
          photocraft.enable = true;
          soundcraft.enable = true;
          vectorcraft.enable = true;
          wordcraft.enable = true;
        };
        enable = true;
      };
    };
  };
  flake-file.inputs.craftapps = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:avivbintangaringga/nix-craftapps";
  };
}
