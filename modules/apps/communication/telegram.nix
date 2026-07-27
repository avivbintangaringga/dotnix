{
  dotnix.telegram.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      ayugram-desktop
    ];
  };
}
