{
  mylib,
  lib,
  inputs,
  userdata,
  pkgs,
  ...
}:
let
  inherit (mylib) enabled disabled;
in
{
  imports = [
    ./../../modules/nixos/import.nix
  ];
}
