{
  den.aspects.telegram = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        ayugram-desktop
      ];
    };
  };
}
