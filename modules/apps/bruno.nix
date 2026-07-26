{
  dotnix.bruno = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        bruno
      ];
    };
  };
}
