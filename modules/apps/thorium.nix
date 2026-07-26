{
 inputs,
 ...
}:
{
  den.aspects.thorium = {
    homeManager = { pkgs, ... }:
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
