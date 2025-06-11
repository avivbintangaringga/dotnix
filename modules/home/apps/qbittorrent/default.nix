{ lib, config, pkgs,... }:
{
  options = {
    setup.apps.qbittorrent.enable = lib.mkEnableOption "QBitTorrent";
  };

  config = lib.mkIf config.setup.apps.qbittorrent.enable {
    home.packages = with pkgs; [
      qbittorrent-enhanced
    ];
  };
}
