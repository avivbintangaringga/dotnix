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
  } @inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
  in {
    inherit lib;
    nixosConfigurations = {
      asus-a15 = lib.nixosSystem {
        modules = [ ./hosts/asus-a15 ];
        specialArgs = {
          inherit inputs;
          pkgs = import nixpkgs {
            system =  "x86_64-linux";
            config.allowUnfree = true;
          };
        };
      };
    };
  };
}
