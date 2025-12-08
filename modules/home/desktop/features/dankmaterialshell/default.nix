{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
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

    programs.dankMaterialShell = {
      enable = true;
    };

    programs.dsearch.enable = true;
  };
}
