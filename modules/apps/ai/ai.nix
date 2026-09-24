{
  dotnix,
  ...
}:
{
  dotnix.ai = {
    includes = with dotnix; [
      ai-usagebar
      codex
      hermes-agent
    ];
  };
}
