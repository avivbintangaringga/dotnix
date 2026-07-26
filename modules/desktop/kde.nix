{
  den.aspects.kde = {
    nixos = { pkgs, lib, ... }: {
      services = {
        xserver = {
          enable = true;
          videoDrivers = [
            "amdgpu"
          ];
        };

        desktopManager = {
          plasma6 = {
            enable = true;
          };
        };
      };

      environment = {
        plasma6.excludePackages = with pkgs.kdePackages; [
          khelpcenter
        ];

        systemPackages = with pkgs; [
          pciutils
        ];
      };

      services.power-profiles-daemon.enable = lib.mkForce false;
    };
  };
}
