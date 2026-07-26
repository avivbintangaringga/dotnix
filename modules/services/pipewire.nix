{
  dotnix.pipewire = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        pwvucontrol
      ];
      services = {
        pipewire = {
          enable = true;
          extraConfig.pipewire = {
            "91-reduce-crackle" = {
              "context.properties" = {
                "default.clock.max-quantum" = 1024;
                "default.clock.min-quantum" = 32;
                "default.clock.quantum" = 512;
                "default.clock.rate" = 48000;
              };
            };
          };
          jack.enable = true;
          pulse.enable = true;
        };
      };
    };
  };
}
