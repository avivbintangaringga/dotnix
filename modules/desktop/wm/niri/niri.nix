{
  dotnix,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-float-sticky = {
      url = "github:probeldev/niri-float-sticky";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  dotnix.niri = {
    includes = with dotnix; [
      noctalia
      vicinae
    ];

    homeManager = { pkgs, ... }: {
      imports = [
        inputs.niri.homeModules.niri
      ];
      home.file = {
        ".config/niri/config.kdl" = {
          source = ./config.kdl;
        };
      };
      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];
      programs.niri = {
        config = null;
        enable = true;
        package = pkgs.niri-unstable;
        settings = null;
      };
      xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
      ];
    };

    nixos =
      { pkgs, ... }:
      let
        system = pkgs.stdenv.hostPlatform.system;
        niri-float-sticky-pkgs = inputs.niri-float-sticky.packages.${system};
      in
      {
        imports = [
          inputs.niri.nixosModules.niri
        ];
        environment.systemPackages =
          (with pkgs; [
            xwayland-satellite
          ])
          ++ (with niri-float-sticky-pkgs; [
            niri-float-sticky
          ]);
        nixpkgs.overlays = [
          inputs.niri.overlays.niri
        ];
        programs.niri = {
          enable = true;
          package = pkgs.niri-unstable;
        };
        systemd.user.services.niri-flake-polkit.enable = false;
      };
  };
}
