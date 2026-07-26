{
  den,
  inputs,
  ...
}:
{
  den.aspects.nix-alien = {
    includes = with den.aspects; [
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
