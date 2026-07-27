{
  dotnix.looking-glass.homeManager = { pkgs, ... }: {
    programs.looking-glass-client = {
      enable = true;
      package = pkgs.looking-glass-client.override {
        pipewireSupport = false;
      };
      settings = {

      };
    };
  };
}
