{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.apps.quickemu.enable = lib.mkEnableOption "QuickEmu";
  };

  config = lib.mkIf config.setup.apps.quickemu.enable {
    home.packages = with pkgs;[
      quickemu
      quickgui
    ];
  };
}
