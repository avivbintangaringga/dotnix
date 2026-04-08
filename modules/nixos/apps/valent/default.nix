{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.apps.valent.enable = lib.mkEnableOption "Valent";
  };

  config = lib.mkIf config.setup.apps.valent.enable {
    environment.systemPackages = with pkgs; [
      valent
    ];

    networking.firewall = rec {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
