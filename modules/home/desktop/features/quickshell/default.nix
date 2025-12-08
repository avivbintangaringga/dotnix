{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in
{
  options = {
    setup.desktop.features.quickshell.enable = lib.mkEnableOption "Quickshell";
  };

  config = lib.mkIf config.setup.desktop.features.quickshell.enable {
    home.packages = [
      quickshell
    ];

    home.file = {
      ".config/quickshell/clock" = {
        source = ./configs/clock;
        recursive = true;
      };
    };
  };
}
