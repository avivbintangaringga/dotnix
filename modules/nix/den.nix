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
    import-tree.url = "github:denful/import-tree";
    flake-file.url = "github:denful/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  imports = [
    (inputs.den.flakeModules.dendritic or {})
    (inputs.flake-file.flakeModules.dendritic or {})
  ];

  den.default.nixos.system.stateVersion = stateVersion;
  den.default.homeManager.home.stateVersion = stateVersion;
}
