{
  dotnix.python.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      ruff
    ];
    programs.uv.enable = true;
  };
}
