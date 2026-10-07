{
  inputs,
  ...
}:
{
  flake-file.inputs.nix-index = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.nix-index.nixos = {
    imports = [
      inputs.nix-index.nixosModules.default
    ];

    programs.nix-index-database = {
      enable = true;
      comma.enable = true;
    };
  };
}
