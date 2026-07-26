{
  inputs,
  ...
}:
{
  flake-file.inputs.qtengine = {
    url = "github:kossLAN/qtengine";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.qt = {
    nixos = { pkgs, user, ... }: {
      imports = [
        inputs.qtengine.nixosModules.default
      ];

      environment.systemPackages = with pkgs; [
        kdePackages.qt6ct
      ];

      programs.qtengine = {
        enable = true;
        config = {
          theme = {
            colorScheme = "/home/${user.userName}/.local/share/color-schemes/noctalia.colors";
            iconTheme = "Papirus";
          };
        };
      };
    };
  };
}
