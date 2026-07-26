{
  dotnix,
  ...
}:
{
  dotnix.downloaders = {
    includes = with dotnix; [
      qbittorrent
    ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        varia
      ];
    };
  };
}
