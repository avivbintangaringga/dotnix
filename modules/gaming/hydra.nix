{
  dotnix.hydra = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        hydralauncher
      ];
    };
  };
}
