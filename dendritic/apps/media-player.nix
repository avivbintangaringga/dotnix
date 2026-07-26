{
  den.aspects.media-player = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        kdePackages.gwenview
        vlc
      ];
    };
  };
}
