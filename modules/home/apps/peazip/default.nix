{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.peazip.enable = lib.mkEnableOption "PeaZip";
  };

  config = lib.mkIf config.setup.apps.peazip.enable {
    home.packages = with pkgs; [
      peazip
    ];
  };
}
