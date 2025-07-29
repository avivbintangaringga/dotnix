{ lib, config, inputs, ... }:
{
  imports = [
    inputs.lsfg-vk.nixosModules.default
  ];
  
  options = {
    setup.services.lsfg-vk.enable = lib.mkEnableOption "LSFG-VK Frame Generation";
  };

  config = lib.mkIf config.setup.services.lsfg-vk.enable {
    services = {
      lsfg-vk = {
        enable = true;
        ui.enable = true;
      };
    };
  };
}
