{
  flake.modules.nixosModules.vfio = {
    security.sudo = {
      enable = true;
      extraRules = [
        {
          # For VFIO script
          commands = [
            {
              command = "/run/current-system/sw/bin/systemctl";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/rmmod";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/modprobe";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/virsh";
              options = [ "NOPASSWD" ];
            }
            {
              command = "/run/current-system/sw/bin/pkill";
              options = [ "NOPASSWD" ];
            }
          ];
          groups = [ "wheel" ];
        }
      ];
    };
  };
}
