{
  inputs,
  ...
}:
{
  dotnix.nix-index = {
    nixos = {
      imports = [
        inputs.nix-index.nixosModules.default
      ];

      programs.nix-index-database = {
        comma.enable = true;
        enable = true;
      };
    };
  };
  flake-file.inputs.nix-index = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:nix-community/nix-index-database";
  };
}
