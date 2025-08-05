{
  lib,
  config,
  ...
}:
{
  options = {
    setup.misc.appimage.enable = lib.mkEnableOption "AppImage compatibility";
  };

  config = lib.mkIf config.setup.misc.appimage.enable {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
