{
  den,
  ...
}:
{
  den.aspects.downloaders = {
    includes = with den.aspects; [
      qbittorrent
    ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        varia
      ];
    };
  };
}
