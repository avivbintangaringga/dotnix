{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    hardware.url = "github:NixOS/nixos-hardware/master";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    aagl,
    spicetify-nix,
    hyprland-contrib,
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
	  ./modules/nixos/aagl
	  home-manager.nixosModules.home-manager
	  hardware.nixosModules.asus-fa506ic
        ];
        specialArgs = {
           inherit lib;
	   inherit userdata;
	   inherit aagl;
        };
      };
    };

    homeConfigurations = {
      ${userdata.username} = let
	spicePkgs = spicetify-nix.legacyPackages.x86_64-linux;
      in lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home-manager/asus-a15.nix
	  spicetify-nix.homeManagerModules.spicetify
        ];
	extraSpecialArgs = {
	  inherit userdata;
	  inherit spicePkgs;
	  inherit hyprland-contrib;
	};
      };
    };
  };
}
