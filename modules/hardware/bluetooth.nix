{
  dotnix.bluetooth = {
  nixos = {
      hardware = {
        bluetooth = {
          enable = true;
          powerOnBoot = true;
        };
      };

      services = {
        blueman.enable = true;
      };
    };
  };
}
