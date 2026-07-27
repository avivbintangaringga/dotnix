{
  dotnix.android-studio.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      android-studio
    ];
  };
}
