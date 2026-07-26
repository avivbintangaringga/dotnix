{
  den.aspects.hydra = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        hydralauncher
      ];
    };
  };
}
