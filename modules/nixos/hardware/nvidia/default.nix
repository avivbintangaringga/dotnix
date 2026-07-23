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
      # nvidia-container-toolkit
    ];

    hardware = {
      graphics.enable = true;

      # nvidia-container-toolkit = {
      #   enable = true;
      # };

      nvidia = {
        powerManagement = {
          enable = true;
          finegrained = false;
        };

        nvidiaPersistenced = true;
      };
    };
  };
}
