{
  dotnix.nvidia.nixos = { config, lib, pkgs, ... }: {
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
        package = config.boot.kernelPackages.nvidiaPackages.new_feature;
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
