{
  den.aspects.qbittorrent = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        qbittorrent-enhanced
      ];
    };
  };
}
