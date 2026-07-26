{
  den.aspects.bruno = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        bruno
      ];
    };
  };
}
