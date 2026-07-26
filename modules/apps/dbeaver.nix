{
  den.aspects.dbeaver = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        dbeaver-bin
      ];
    };
  };
}
