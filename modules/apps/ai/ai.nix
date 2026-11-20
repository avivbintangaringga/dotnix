{
  dotnix,
  ...
}:
{
  dotnix.ai = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        rtk
      ];
    };
    includes = with dotnix; [
      ai-usagebar
      llm-agents
      opencode
      command-code
      # codex
      # hermes-agent
    ];
  };
}
