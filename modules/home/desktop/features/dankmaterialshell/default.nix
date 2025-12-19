{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  quickshell = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  imports = [
    inputs.dankmaterialshell.homeModules.dankMaterialShell.default
    inputs.dsearch.homeModules.default
  ];

  options = {
    setup.desktop.features.dankmaterialshell.enable = lib.mkEnableOption "DankMaterialShell";
  };

  config = lib.mkIf config.setup.desktop.features.dankmaterialshell.enable {
    home.sessionVariables = {
      DMS_MODAL_LAYER="overlay";
      DMS_NOTIFICATION_LAYER="overlay";
      QT_QPA_PLATFORMTHEME="gtk4";
      DMS_SCREENSHOT_EDITOR="satty";
    };
    
    home.packages = with pkgs; [
      satty
    ];

    programs.dank-material-shell = {
      enable = true;
      quickshell.package = quickshell;
    };

    programs.dsearch.enable = true;
  };
}
