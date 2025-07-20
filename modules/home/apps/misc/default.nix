{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.misc.enable = lib.mkEnableOption "Miscellaneous Apps";
  };

  config = lib.mkIf config.setup.apps.misc.enable {
    home.packages = with pkgs; [
      font-manager
      # reaper
      varia
      lxappearance
      nwg-look
      btrfs-assistant
      remmina

      appimage-run

      dmidecode

      #testing
      vulkan-tools
      gedit
      nautilus
      kdePackages.dolphin
      kdePackages.dolphin-plugins
      kdePackages.kate
      # vivaldi
      # brave
    ];
  };
}
