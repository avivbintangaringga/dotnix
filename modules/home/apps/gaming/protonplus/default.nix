{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.gaming.protonplus.enable = lib.mkEnableOption "ProtonPlus";
  };

  config = lib.mkIf config.setup.apps.gaming.protonplus.enable {
    home.packages = with pkgs; [
      protonplus
    ];
  };
}
