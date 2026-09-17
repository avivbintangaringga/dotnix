{
  inputs,
  ...
}:
{
  dotnix.snappy-switcher = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        snappy-switcher
      ];
      nixpkgs.overlays = [
        inputs.snappy-switcher.overlays.default
      ];
    };
  };
  flake-file.inputs.snappy-switcher = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:OpalAayan/snappy-switcher";
  };
}
