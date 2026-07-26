{
  dotnix.python = {
    homeManager = { pkgs, ... }: {
      programs.uv.enable = true;
      home.packages = with pkgs; [
        ruff
      ];
    };
  };
}
