{
  dotnix.heroic = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        heroic
      ];
    };
  };
}
