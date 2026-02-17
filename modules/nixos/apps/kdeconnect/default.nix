{
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.kdeconnect.enable = lib.mkEnableOption "KDE Connect";
  };

  config = lib.mkIf config.setup.apps.kdeconnect.enable {
    programs.kdeconnect = {
      enable = true;
    };

    networking.firewall = rec {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
