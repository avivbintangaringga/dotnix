{
  dotnix.localsend = {
    nixos = {
      programs.localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
