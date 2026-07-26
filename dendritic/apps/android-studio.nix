{
  den.aspects.android-studio = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        android-studio
      ];
    };
  };
}
