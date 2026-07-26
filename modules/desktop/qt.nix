{
  inputs,
  ...
}:
{
  flake-file.inputs.qtengine = {
    url = "github:kossLAN/qtengine";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.qt = {
    nixos = { user, pkgs, ... }: {
      imports = [
        inputs.qtengine.nixosModules.default
      ];

      environment.systemPackages = with pkgs; [
        kdePackages.qt6ct
      ];

      programs.qtengine = {
        config = {
          theme = {
            colorScheme = "/home/${user.userName}/.local/share/color-schemes/noctalia.colors";
            iconTheme = "Papirus";
          };
        };
        enable = true;
      };
    };
  };
}
