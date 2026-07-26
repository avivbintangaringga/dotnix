{
  den.aspects.image-editors = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        gimp
      ];
    };
  };
}
