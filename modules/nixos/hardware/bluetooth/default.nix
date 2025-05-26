{ lib, config, ... }:
{
  options = {
    setup.hardware.bluetooth.enable = lib.mkEnableOption "Bluetooth";
  };

  config = lib.mkIf config.setup.hardware.bluetooth.enable {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };

    services = {
      blueman.enable = true;
    };
  };
}
