{
  dotnix.openspec.homeManager = { pkgs, ... }: {
    home.packages = with pkgs.llm-agents; [
      openspec
    ];
  };
}
