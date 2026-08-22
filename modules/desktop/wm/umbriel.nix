{
  inputs,
  ...
}:
{
  dotnix.umbriel = {
    homeManager = {
      imports = [
        inputs.umbriel.homeModules.default
      ];

      nixpkgs.overlays = [
        inputs.umbriel.overlays.default
        inputs.xdg-desktop-portal-umbriel.overlays.default
      ];

      programs.umbriel = {
        enable = true;
        settings = {

        };
      };
    };

    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        xdg-desktop-portal-umbriel
      ];
      imports = [
        inputs.umbriel.nixosModules.default
      ];
      nixpkgs.overlays = [
        inputs.umbriel.overlays.default
        inputs.xdg-desktop-portal-umbriel.overlays.default
      ];
      programs.umbriel.enable = true;
    };
  };
  flake-file.inputs = {
    umbriel = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:noctalia-dev/umbriel";
    };
    xdg-desktop-portal-umbriel = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:noctalia-dev/xdg-desktop-portal-umbriel";
    };
  };
}
