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
      nvidia-container-toolkit
    ];

    # systemd = {
    #   services = {
    #     "nvidia-powerd" = {
    #       enable = false;
    #       wantedBy = lib.mkForce [];
    #     };
    #   };
    # };

    # environment.variables = {
    #   __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json";
    # };

    hardware = {
      graphics.enable = true;
      nvidia-container-toolkit = {
        enable = true;
      };
      nvidia = {
        modesetting.enable = true;
        open = false;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          nvidiaBusId = lib.mkForce "PCI:1:0:0";
          amdgpuBusId = lib.mkForce "PCI:6:0:0";
        };
        powerManagement = {
          enable = true;
          finegrained = false;
        };
        dynamicBoost = {
          enable = false;
        };
        nvidiaPersistenced = true;
      };
    };

    boot.extraModprobeConfig = ''
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x1; PowerMizerDefaultAC=0x1"
      options nvidia_drm modeset=1
    '';
  };
}
