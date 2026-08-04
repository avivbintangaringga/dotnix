{
  dotnix.python.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      python3
      ruff
    ];
    programs.uv.enable = true;
  };
}
