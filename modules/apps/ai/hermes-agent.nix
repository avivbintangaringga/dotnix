{
  inputs,
  ...
}:
{
  flake-file.inputs.hermes-agent.url = "github:NousResearch/hermes-agent";

  dotnix.hermes-agent.homeManager = {
    imports = [
      inputs.hermes-agent.homeManagerModules.default
    ];

    programs.hermes-agent = {
      enable = true;
      desktop.enable = true;
    };

    services.hermes-agent = {
      enable = true;
      gateway.enable = true;
    };
  };
}
