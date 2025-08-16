{ lib, config, pkgs, ... }:
{
  options = {
    setup.apps.moonlight.enable = lib.mkEnableOption "Moonlight";
  };

  config = lib.mkIf config.setup.apps.moonlight.enable {
    home.packages = with pkgs; [
      moonlight-qt
    ];
  };
}
