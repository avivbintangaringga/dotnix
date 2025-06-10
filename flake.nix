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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvix.url = "github:niksingh710/nvix";

    nix-alien.url = "github:thiagokokada/nix-alien";

    apple-fonts.url= "github:Lyndeno/apple-fonts.nix";

    zen-nebula.url = "github:JustAdumbPrsn/Nebula-A-Minimal-Theme-for-Zen-Browser";
  };

  outputs =
    {
      self,
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
