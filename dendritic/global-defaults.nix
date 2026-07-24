{
  inputs,
  lib,
  ...
}:
let
  stateVersion = "24.11";
in
{
  imports = [ inputs.den.flakeModule ];
  den.schema.user.classes = lib.mkDefault [ ];
  den.default.nixos.system.stateVersion = stateVersion;
  den.default.homeManager.home.stateVersion = stateVersion;
}
