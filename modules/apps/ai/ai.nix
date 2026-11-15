{
  dotnix,
  ...
}:
{
  dotnix.ai = {
    includes = with dotnix; [
      ai-usagebar
      # codex
      # hermes-agent
      opencode
    ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        rtk
      ];
    };
  };
}
