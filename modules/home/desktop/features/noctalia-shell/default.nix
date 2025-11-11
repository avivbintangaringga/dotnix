{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # inputs.noctalia-shell.homeModules.default
  ];

  options = {
    setup.desktop.features.noctalia-shell.enable = lib.mkEnableOption "Noctalia Shell";
  };

  config = lib.mkIf config.setup.desktop.features.noctalia-shell.enable {
    # home.packages = with pkgs; [
    #   # inputs.quickshell.packages.${system}.default
    #   libsForQt5.qt5ct
    #   kdePackages.qt6ct
    # ];

    # programs.noctalia-shell = {
    #   enable = true;
    #   settings = { };
    # };
  };
}
