{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware = {
      url = "github:avivbintangaringga/nixos-hardware/fa506ic-fix";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    thorium-browser = {
      url = "github:Rishabh5321/custom-packages-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.niri-unstable.url = "github:niri-wm/niri/wip/branch";
    };

    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankmaterialshell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dsearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-float-sticky = {
      url = "github:probeldev/niri-float-sticky";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    import-tree = {
      url = "github:vic/import-tree";
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
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
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
