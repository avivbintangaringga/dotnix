{
  dotnix,
  inputs,
  ...
}:
{
  flake-file.inputs.dankmaterialshell = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.dankmaterialshell = {
    includes = with dotnix; [
      dankgreet
    ];

    homeManager = { pkgs, ... }: {
      imports = [
        inputs.dankmaterialshell.homeModules.dank-material-shell
      ];

      programs.dank-material-shell = {
        enable = true;
      };

      home = {
        packages = with pkgs; [
          satty
          kdePackages.qt6ct
          cups-pk-helper
        ];

        sessionVariables = {
          DMS_MODAL_LAYER="overlay";
          DMS_NOTIFICATION_LAYER="overlay";
          QT_QPA_PLATFORMTHEME="gtk4";
          DMS_SCREENSHOT_EDITOR="satty";
        };

        file = {
          ".config/niri/dms-overrides.kdl" = {
            source = ./niri/dms-overrides.kdl;
          };
        };
      };

      gtk = {
        gtk3 = {
          extraCss = ''
            @import url("dank-colors.css");
          '';
        };

        gtk4 = {
          extraCss = ''
            @import url("dank-colors.css");
          '';
        };
      };
    };
  };
}
