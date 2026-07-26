{
  den.aspects.gedit = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        gedit
      ];
    };
  };
}
