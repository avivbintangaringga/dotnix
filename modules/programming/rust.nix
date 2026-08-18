{
  inputs,
  ...
}:
{
  dotnix.rust.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      rust-bin.stable.latest.default
    ];
    home.sessionPath = [ "$HOME/.cargo/bin" ];
    nixpkgs.overlays = [
      inputs.rust-overlay.overlays.default
    ];
  };

  flake-file.inputs.rust-overlay = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:oxalica/rust-overlay";
  };
}
