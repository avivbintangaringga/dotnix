{
  dotnix.go = {
    homeManager = { pkgs, ... }: {
      programs.go.enable = true;
      home.packages = with pkgs;[
        air
        gcc
        go-jet
        goose
        gopls
        templ
      ];
    };
  };
}
