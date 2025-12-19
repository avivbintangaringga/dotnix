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
      alacritty
      # font-manager
      # reaper
      varia
      lxappearance
      nwg-look
      btrfs-assistant
      remmina
      bluemail

      gimp

      vicinae

      # dmidecode

      # furmark
      # mprime
      # synthesia

      #testing
      gedit
      # kdePackages.dolphin
      # kdePackages.dolphin-plugins
      # kdePackages.kate
      # vivaldi
      # brave

      # winboat
      # freerdp
      #

      # pgadmin4-desktopmode
    ]);
  };
}
