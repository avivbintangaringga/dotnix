{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib // home-manager.lib;
  in {
    nixosConfigurations = {
      asus-a15 = lib.nixosSystem {
        modules = [ ./hosts/asus-a15 ];
        specialArgs = {
           inherit lib;
        };
      };
    };
  };
}
