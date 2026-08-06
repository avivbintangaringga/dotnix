{
  dotnix,
  inputs,
  ...
}:
{
  flake-file.inputs.niri = {
    url = "github:epireyn/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
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
      home.file.".config/niri/config.kdl".source = ./config.kdl;
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];
      xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
      ];
    };

    nixos = { pkgs, ... }: {
      imports = [
        inputs.niri.nixosModules.niri
      ];
      environment.systemPackages = with pkgs; [
        xwayland-satellite
        nirius
      ];
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      nixpkgs.overlays = [
        inputs.niri.overlays.niri
      ];
      systemd.user.services.niri-flake-polkit.enable = false;
    };
  };
}
