{
  dotnix.kde = {
    nixos = { lib, pkgs, ... }: {
      environment = {
        plasma6.excludePackages = with pkgs.kdePackages; [
          khelpcenter
        ];

        systemPackages = with pkgs; [
          pciutils
        ];
      };
      services = {
        desktopManager = {
          plasma6 = {
            enable = true;
          };
        };
        power-profiles-daemon.enable = lib.mkForce false;
        xserver = {
          enable = true;
          videoDrivers = [
            "amdgpu"
          ];
        };
      };
    };
  };
}
