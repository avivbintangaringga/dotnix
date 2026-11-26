{
  dotnix.wpsoffice = {
    homeManager = { pkgs, ... }: {
      home.packages = [
        (pkgs.callPackage ./_package.nix { })
      ];
    };
  };
}
