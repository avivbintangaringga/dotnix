{
  dotnix.power-profiles-daemon = {
    nixos = {
      services.power-profiles-daemon = {
        enable = true;
      };
    };
  };
}
