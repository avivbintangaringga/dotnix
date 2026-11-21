{
  inputs,
  ...
}:
{
  dotnix.luciole = {
    homeManager = {
      imports = [
        inputs.luciole.homeModules.default
      ];

      programs.luciole.enable = true;
    };
    nixos = {
      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };
    };
  };
  flake-file.inputs.luciole = {
    url = "github:noctalia-dev/luciole/cachix";
  };
}
