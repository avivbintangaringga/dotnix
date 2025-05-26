{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.hardware.nvidia.enable = lib.mkEnableOption "Nvidia Drivers";
  };

  config = lib.mkIf config.setup.hardware.nvidia.enable {
    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
      nvtopPackages.amd
    ];

    hardware = {
      graphics.enable = true;
      nvidia = {
        modesetting.enable = true;
        prime = {
          nvidiaBusId = lib.mkForce "PCI:1:0:0";
          amdgpuBusId = lib.mkForce "PCI:6:0:0";
        };
      };
    };
  };
}
