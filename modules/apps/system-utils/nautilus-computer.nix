{
  inputs,
  ...
}:
{
  dotnix.nautilus-computer = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        inputs.nautilus-computer.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
  flake-file.inputs.nautilus-computer = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:yannmasoch/nautilus-my-computer?dir=packaging/nix";
  };
}
