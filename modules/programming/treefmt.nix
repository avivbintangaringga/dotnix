{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    pedantix.url = "github:swarsel/pedantix";
    treefmt.url = "github:numtide/treefmt-nix";
  };

  imports = [
    inputs.treefmt.flakeModule
    inputs.pedantix.flakeModules.default
  ];

  perSystem = _: {
    treefmt.programs.pedantix.enable = true;
  };
}
