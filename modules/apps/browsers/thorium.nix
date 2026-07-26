{
  inputs,
  ...
}:
{
  flake-file.inputs.thorium-browser = {
    url = "github:Rishabh5321/custom-packages-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.thorium = {
    homeManager =
      { pkgs, ... }:
      let
        thorium-pkgs = inputs.thorium-browser.packages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        home.packages = with thorium-pkgs; [
          thorium-avx2
        ];
      };
  };
}
