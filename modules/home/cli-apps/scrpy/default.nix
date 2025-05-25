{ pkgs, lib, config, ... }:
{
  options = {
    setup.cli-apps.scrcpy.enable = lib.mkEnableOption "Scrcpy";
  };

  config = lib.mkIf config.setup.cli-apps.scrcpy.enable {
    home.packages = with pkgs; [
      scrcpy
    ];
  };
}
