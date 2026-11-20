{
  dotnix.opencode = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs.llm-agents; [
        opencode2
      ];
      # multiverse.pins.opencode = "2.2.1";
    };
  };
}
