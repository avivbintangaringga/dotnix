{
  dotnix.codex = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        codex
      ];
    };
  };
}
