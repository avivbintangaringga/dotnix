{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hardware,
    aagl,
    nixvim,
    spicetify-nix,
    hyprland-contrib,
    zen-browser,
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
          ./home/${userdata.username}.nix
        ];
	extraSpecialArgs = {
	  inherit inputs;
	  inherit userdata;
	  inherit spicePkgs;
	  inherit hyprland-contrib;
	};
      };
    };
  };
}
