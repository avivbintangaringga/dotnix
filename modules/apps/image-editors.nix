{
  dotnix.image-editors = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        gimp
      ];
    };
  };
}
