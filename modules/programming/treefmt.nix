{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    treefmt.url = "github:numtide/treefmt-nix";
    pedantix.url = "github:swarsel/pedantix";
  };

  imports = [
    inputs.treefmt.flakeModule
    inputs.pedantix.flakeModules.default
  ];

  perSystem = _: {
    treefmt = {
      programs.pedantix.enable = true;
    };
  };
}
