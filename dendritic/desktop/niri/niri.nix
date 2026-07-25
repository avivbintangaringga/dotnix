{
  den,
  ...
}:
{
  den.aspects.niri = {
    includes = with den.aspects; [
      noctalia
    ];

    homeManager = { inputs, pkgs, ... }: {
      imports = [
        inputs.niri.homeModules.niri
      ];

      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];

      home.file = {
        ".config/niri/config.kdl" = {
          source = ./config.kdl;
        };
      };

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
        config = null;
        settings = null;
      };
    };

    nixos = { inputs, pkgs, ... }: let
      system = pkgs.stdenv.hostPlatform.system;
      niri-float-sticky-pkgs = inputs.niri-float-sticky.packages.${system};
    in {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];

      environment.systemPackages = (with pkgs; [
        xwayland-satellite
      ])
      ++
      (with niri-float-sticky-pkgs; [
        niri-float-sticky
      ]);

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };

      systemd.user.services.niri-flake-polkit.enable = false;
    };
  };
}
