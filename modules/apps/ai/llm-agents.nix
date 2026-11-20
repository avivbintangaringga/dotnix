{
  inputs,
  ...
}:
{
  dotnix.llm-agents = {
    homeManager = {
      nixpkgs.overlays = [
        inputs.llm-agents.overlays.shared-nixpkgs
      ];
    };
    nixos = {
      nix.settings = {
        extra-substituters = [ "https://cache.numtide.com" ];
        extra-trusted-public-keys = [
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
      };
      nixpkgs.overlays = [
        inputs.llm-agents.overlays.shared-nixpkgs
      ];
    };
  };
  flake-file.inputs.llm-agents = {
    url = "github:numtide/llm-agents.nix";
  };
}
