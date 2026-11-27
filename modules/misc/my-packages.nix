{
  inputs,
  ...
}:
{
  dotnix.my-packages = {
    homeManager = {
      nixpkgs.overlays = [
        inputs.my-packages.overlays.default
      ];
    };
    nixos = {
      nixpkgs.overlays = [
        inputs.my-packages.overlays.default
      ];
    };
  };

  flake-file.inputs.my-packages = {
    url = "github:avivbintangaringga/packages.nix";
  };
}
