{
  inputs,
  ...
}:
{
  flake-file.inputs.rust-overlay = {
    url = "github:oxalica/rust-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.rust.homeManager = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        rust-bin.stable.latest.default
      ];
      sessionPath = [ "$HOME/.cargo/bin" ];
    };
    nixpkgs.overlays = [
      inputs.rust-overlay.overlays.default
    ];
  };
}
