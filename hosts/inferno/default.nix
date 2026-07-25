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

  setup = {
    cli-apps = {
      helix = enabled;
      nvim = enabled;
      nix-alien = disabled;
    };
  };
}
