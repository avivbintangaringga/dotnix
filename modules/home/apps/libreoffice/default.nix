{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.apps.libreoffice.enable = lib.mkEnableOption "LibreOffice";
  };

  config = lib.mkIf config.setup.apps.libreoffice.enable {
    home.sessionVariables = {
      SAL_USE_VCLPLUGIN = "kf6";
    };
    
    home.packages = with pkgs; [
      libreoffice-qt6-fresh
    ];
  };
}
