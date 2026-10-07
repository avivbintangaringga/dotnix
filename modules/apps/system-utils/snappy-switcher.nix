{
  inputs,
  ...
}:
{
  flake-file.inputs.snappy-switcher = {
    url = "github:OpalAayan/snappy-switcher";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.snappy-switcher.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      snappy-switcher
    ];
    nixpkgs.overlays = [
      inputs.snappy-switcher.overlays.default
    ];
  };
}
