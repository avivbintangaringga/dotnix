inputs: inputs.flake-parts.lib.mkFlake {
  inherit inputs;
  specialArgs = {
    flake-root = ./.;
  };
} (inputs.import-tree ./modules)
