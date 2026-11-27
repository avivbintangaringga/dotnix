{
  dotnix.libredb.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        libredb-studio
      ];
    };
}
