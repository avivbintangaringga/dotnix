{ lib, config, pkgs, ... }:
{
  options = {
    setup.services.pipewire.enable = lib.mkEnableOption "Pipewire";
  };

  config = lib.mkIf config.setup.services.pipewire.enable {
    services = {
      pipewire = {
        enable = true;
        pulse.enable = true;
        jack.enable = true;
        extraConfig.pipewire = {
          "91-reduce-crackle" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.quantum" = 512;
              "default.clock.min-quantum" = 32;
              "default.clock.max-quantum" = 1024;
            };
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      # coppwr
      # helvum
      pwvucontrol
      # qpwgraph
      # sonusmix
      # carla
    ];
  };
}
