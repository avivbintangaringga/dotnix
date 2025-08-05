{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
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

    nvix = {
      url = "github:niksingh710/nvix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts = {
      url= "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thorium-browser = {
      url = "github:Rishabh5321/thorium_flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lsfg-vk = {
      url = "github:pabloaul/lsfg-vk-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gauntlet = {
      url = "github:project-gauntlet/gauntlet/32bf43438c1b72a0fc53a8b0b128b5c2405f5b7b";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      mylib = (import ./lib);
      lib = nixpkgs.lib // home-manager.lib;
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      myPkgs = (import ./pkgs { inherit pkgs; });
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
    in
    {
      nixosConfigurations = {
        inferno = lib.nixosSystem {
          modules = [
            ./hosts/inferno
          ];
          specialArgs = {
            inherit inputs;
            inherit userdata;
            inherit mylib;
            inherit myPkgs;
          };
        };
      };

      homeConfigurations = {
        ${userdata.username} = lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/${userdata.username}.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit userdata;
            inherit mylib;
            inherit myPkgs;
          };
        };
      };
    };
}
