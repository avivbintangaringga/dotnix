{
  dotnix.looking-glass = {
    homeManager = { pkgs, ... }: {
      programs.looking-glass-client = {
        enable = true;
        settings = {

        };
        package = pkgs.looking-glass-client.override {
          pipewireSupport = false;
        };
      };
    };
  };
}
