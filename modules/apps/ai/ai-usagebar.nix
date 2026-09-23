{
  inputs,
  ...
}:
{
  dotnix.ai-usagebar = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        ai-usagebar
      ];
      nixpkgs.overlays = [
        inputs.ai-usagebar.overlays.default
      ];
    };
  };
  flake-file.inputs.ai-usagebar = {
    url = "github:akitaonrails/ai-usagebar";
  };
}
