{
  dotnix.libredb.homeManager =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.callPackage ./_package.nix { })
      ];
    };
}
