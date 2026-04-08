{ lib, config, pkgs, ... }:
{
  options = {
    setup.services.kdeconnect.enable = lib.mkEnableOption "KDE Connect";
  };

  config = lib.mkIf config.setup.services.kdeconnect.enable {
    services.kdeconnect = {
      enable = true;
    };
  };
}
