{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.gaming.bottles.enable = lib.mkEnableOption "Bottles Launcher";
  };

  config = lib.mkIf config.setup.apps.gaming.bottles.enable {
    home.packages = with pkgs; [
      (bottles.override {
        removeWarningPopup = true;
      })
    ];
  };
}
