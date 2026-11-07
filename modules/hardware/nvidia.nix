{
  dotnix.nvidia.nixos = { lib, pkgs, ... }: {
    environment = {
      sessionVariables = {
        __GL_SHADER_DISK_CACHE_SIZE = 53687091200;
        __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = 1;
      };
      systemPackages = with pkgs; [
        nvtopPackages.nvidia
        nvtopPackages.amd
      ];
    };
    hardware = {
      graphics.enable = true;
      nvidia = {
        modesetting.enable = lib.mkForce true;
        nvidiaPersistenced = lib.mkForce true;
        dynamicBoost.enable = lib.mkForce true;
        powerManagement = {
          enable = lib.mkForce true;
          finegrained = false;
        };
      };
    };
  };
}
