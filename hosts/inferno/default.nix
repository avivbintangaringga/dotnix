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
      home-manager = enabled;
      misc = enabled;
      nh = enabled;
      nvim = enabled;
      nix-alien = disabled;
    };
  };
}
