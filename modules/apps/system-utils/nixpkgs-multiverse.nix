{
  inputs,
  ...
}:
{
  dotnix.nixpkgs-multiverse = {
    homeManager = {
      imports = [
        inputs.multiverse.homeManagerModules.default
      ];

      multiverse = {
        config.allowUnfree = true;
        enable = true;
      };
    };

    nixos = {
      imports = [
        inputs.multiverse.nixosModules.default
      ];

      multiverse = {
        config.allowUnfree = true;
        enable = true;
      };
    };
  };
  flake-file.inputs.multiverse = {
    url = "github:fzakaria/nixpkgs-multiverse";
  };
}
