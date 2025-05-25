{ lib, config, ... }:
{
  options = {
    setup.services.pipewire.enable = lib.mkEnableOption "Pipewire";
  };

  config = lib.mkIf config.setup.services.pipewire.enable {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
