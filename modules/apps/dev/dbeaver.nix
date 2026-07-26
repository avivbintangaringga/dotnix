{
  dotnix.dbeaver = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        dbeaver-bin
      ];
    };
  };
}
