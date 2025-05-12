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
    userdata = rec {
       username = "r7fx";
       userpath = "/home/" + username;
       fullname = "R7FX";
       email = "avivbintangaringga90@gmail.com";
       git = {
         username = "avivbintangaringga";
	 inherit email;
       };
    };
  in {
    nixosConfigurations = {
      asus-a15 = lib.nixosSystem {
        modules = [ 
          ./hosts/asus-a15
        ];
        specialArgs = {
           inherit lib;
	   inherit userdata;
        };
      };
    };

    homeConfigurations = {
      asus-a15 = lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home-manager/asus-a15.nix
        ];
	extraSpecialArgs = {
	  inherit userdata;
	};
      };
    };
  };
}
