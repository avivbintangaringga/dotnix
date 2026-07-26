{
  den.aspects.mangohud = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        goverlay
        mangohud
      ];
    };
  };
}
