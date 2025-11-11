{ lib, config, pkgs, ... }:
{
  options = {
    setup.apps.android-studio.enable = lib.mkEnableOption "Android Studio";
  };

  config = lib.mkIf config.setup.apps.android-studio.enable {
    home.packages = with pkgs; [
      android-studio
    ];
  };
}
