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
    outputs = "inputs: import ./outputs.nix inputs";
  };

  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
  ];
}
