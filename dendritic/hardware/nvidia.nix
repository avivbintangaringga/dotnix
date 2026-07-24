{
  den.aspects.nvidia = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        nvtopPackages.nvidia
        nvtopPackages.amd
      ];

      hardware = {
        graphics.enable = true;
        nvidia = {
          powerManagement = {
            enable = true;
            finegrained = false;
          };

          nvidiaPersistenced = true;
        };
      };
    };
  };
}
