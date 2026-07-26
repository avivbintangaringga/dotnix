{
  dotnix.nvidia = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        nvtopPackages.nvidia
        nvtopPackages.amd
      ];

      hardware = {
        graphics.enable = true;
        nvidia = {
          nvidiaPersistenced = true;
          powerManagement = {
            enable = true;
            finegrained = false;
          };
        };
      };
    };
  };
}
