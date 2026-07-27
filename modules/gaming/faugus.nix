{
  dotnix.faugus.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      faugus-launcher
    ];
  };
}
