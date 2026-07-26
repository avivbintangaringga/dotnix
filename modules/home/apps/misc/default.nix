{
  pkgs,
  myPkgs,
  inputs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.misc.enable = lib.mkEnableOption "Miscellaneous Apps";
  };

  config = lib.mkIf config.setup.apps.misc.enable {
    home.packages = (with pkgs; [
      varia
      btrfs-assistant
      bluemail

      dbeaver-bin
      bruno

      ferdium
      resources

      gimp

      vicinae
    ]);
  };
}
