{
  inputs,
  ...
}:
{
  flake-file = {
    inputs.flake-file.url = "github:denful/flake-file";
    description = "My NixOS config :)";
  };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
  ];
}
