{
  dotnix.command-code.homeManager = { pkgs, ... }: {
    home.packages = with pkgs.llm-agents; [
      command-code
    ];
  };
}
