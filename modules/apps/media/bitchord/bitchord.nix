{
  dotnix.bitchord.homeManager =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.callPackage ./_package.nix { })
      ];
    };
}
