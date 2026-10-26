{
  dotnix.ai-usagebar.homeManager =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.callPackage ./_package.nix { })
      ];
    };
}
