{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.ayugram.enable = lib.mkEnableOption "Ayugram";
  };

  config = lib.mkIf config.setup.apps.ayugram.enable {
    home.packages = with pkgs; [
      ayugram-desktop
    ];
  };
}
