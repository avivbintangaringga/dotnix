{
  den.aspects.ferdium = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        ferdium
      ];
    };
  };
}
