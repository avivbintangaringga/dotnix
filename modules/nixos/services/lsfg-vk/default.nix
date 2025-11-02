{ lib, config, pkgs, ... }:
{
  options = {
    setup.services.lsfg-vk.enable = lib.mkEnableOption "LSFG-VK Frame Generation";
  };

  config = lib.mkIf config.setup.services.lsfg-vk.enable {
    environment.systemPackages = with pkgs; [
      lsfg-vk
      lsfg-vk-ui
    ];
  };
}
