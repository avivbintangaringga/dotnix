{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  options = {
    setup.desktop.features.quickshell.enable = lib.mkEnableOption "Quickshell";
  };

  config = lib.mkIf config.setup.desktop.features.quickshell.enable {
    home.packages = with pkgs; [
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
