{
  dotnix.codex.homeManager = { pkgs, ... }: {
    home.packages = with pkgs.llm-agents; [
      codex
    ];
  };
}
