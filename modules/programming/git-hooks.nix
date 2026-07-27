{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    git-hooks.url = "github:cachix/git-hooks.nix";
  };

  imports = [
    inputs.git-hooks.flakeModule
  ];

  perSystem = {
    pre-commit.settings.hooks.treefmt.enable = true;
  };
}
