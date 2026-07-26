{
  inputs,
  ...
}:
let
  stateVersion = "24.11";
in
{
  imports = [ inputs.den.flakeModule ];
  den.default.nixos.system.stateVersion = stateVersion;
  den.default.homeManager.home.stateVersion = stateVersion;
}
