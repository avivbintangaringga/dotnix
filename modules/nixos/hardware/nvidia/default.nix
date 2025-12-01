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

    systemd = {
      services = {
        "nvidia-powerd" = {
          wantedBy = lib.mkForce [];
        };
      };
    };

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
          nvidiaBusId = lib.mkForce "PCI:1:0:0";
          amdgpuBusId = lib.mkForce "PCI:6:0:0";
        };
      };
    };
  };
}
