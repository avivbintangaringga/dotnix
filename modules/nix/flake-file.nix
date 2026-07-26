{
  inputs,
  ...
}:
{
  flake-file = {
    description = "My NixOS config :)";
    inputs = {
      flake-file.url = "github:denful/flake-file";
    };
  };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
  ];
}
