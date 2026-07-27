{
  inputs,
  ...
}:
let
  stateVersion = "24.11";
in
{
  flake-file.inputs.den.url = "github:denful/den";

  imports = [
    (inputs.den.flakeModules.dendritic or { })
    (inputs.den.namespace "dotnix" true)
  ];

  den.default = {
    homeManager.home.stateVersion = stateVersion;
    nixos.system.stateVersion = stateVersion;
  };
}
