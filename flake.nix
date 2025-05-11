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
  }@inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
  in {
    nixosConfigurations = {
      asus-a15 = lib.nixosSystem {
        modules = [ 
          ./hosts/asus-a15
        ];
        specialArgs = {
           inherit lib;
        };
      };
    };
    homeConfigurations.r7fx = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./users/r7fx/home.nix
      ];
    };
  };
}
