{
  den.aspects.qt = {
    nixos = { inputs, pkgs, user, ... }: {
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
