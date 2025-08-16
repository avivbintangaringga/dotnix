{ pkgs-4c3870b, pkgs-ca3d8cc, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      mesa-25-1-7 = pkgs-ca3d8cc.mesa;
      mesa-25-1-6 = pkgs-4c3870b.mesa;
    })
  ];
}
