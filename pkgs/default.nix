{pkgs ? import <nixpkgs> {}, ...}: {
  faugus-launcher = pkgs.callPackage ./faugus-launcher/package.nix {};
}
