{
  inputs,
  ...
}:
{
  flake-file.inputs.hermes-agent.url = "github:NousResearch/hermes-agent";

  dotnix.hermes-agent.homeManager = { pkgs, ... }: {
    imports = [
      inputs.hermes-agent.homeManagerModules.default
    ];

    home.packages = with pkgs;[
      ffmpeg-full
      ripgrep
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
