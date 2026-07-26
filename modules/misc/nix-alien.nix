{
  dotnix,
  inputs,
  ...
}:
{
  flake-file.inputs.nix-alien = {
    url = "github:thiagokokada/nix-alien";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.nix-alien = {
    includes = with dotnix; [
      nix-ld
    ];

    nixos = { pkgs, ... }:
    let
      alien-pkgs = inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.systemPackages = with alien-pkgs; [
        nix-alien
      ];
    };
  };
}
