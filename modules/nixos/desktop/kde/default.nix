{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.desktop.kde.enable = lib.mkEnableOption "KDE Desktop Environment";
  };

  config = lib.mkIf config.setup.desktop.kde.enable {
    services = {
      xserver = {
        enable = true;
      };

      desktopManager = {
        plasma6 = {
          enable = true;
        };
      };
    };

    environment = {
      plasma6.excludePackages = with pkgs.kdePackages; [
        khelpcenter
      ];

      systemPackages = with pkgs; [
        pciutils
      ];
    };

    services.power-profiles-daemon.enable = lib.mkForce false;
  };
}
