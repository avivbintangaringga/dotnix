{
  inputs,
  ...
}:
{
  dotnix.guesthouse.nixos = {
    imports = [
      inputs.guesthouse.nixosModules.default
    ];

    programs.guesthouse.enable = true;
  };
  flake-file.inputs.guesthouse = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:xnixy/guesthouse/nixos-test";
  };
}
