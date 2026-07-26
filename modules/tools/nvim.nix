{
  inputs,
  ...
}:
{
  flake-file.inputs.nvix = {
    url = "github:niksingh710/nvix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.nvim = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        inputs.nvix.packages.${pkgs.stdenv.hostPlatform.system}.bare
      ];
    };

    nixos = {
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
      };
    };
  };
}
