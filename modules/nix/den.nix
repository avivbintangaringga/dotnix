{
  inputs,
  ...
}:
let
  stateVersion = "24.11";
in
{
  flake-file.inputs = {
    den.url = "github:denful/den";
  };

  imports = [
    (inputs.den.flakeModules.dendritic or {})
  ];

  den.default.nixos.system.stateVersion = stateVersion;
  den.default.homeManager.home.stateVersion = stateVersion;
}
