{ lib, config, ... }:
{
  options = {
    setup.services.cliphist.enable = lib.mkEnableOption "Cliphist";
  };

  config = lib.mkIf config.setup.services.cliphist.enable {
    services.cliphist = {
      enable = true;
    };
  };
}
