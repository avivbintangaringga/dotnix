{ lib, config, ... }:
{
  options = {
    setup.services.gvfs.enable = lib.mkEnableOption "GVFS";
  };

  config = lib.mkIf config.setup.services.gvfs.enable {
    gvfs = {
      enable = true;
    };
  };
}
