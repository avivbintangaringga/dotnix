{
  dotnix.moonlight = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        moonlight-qt
      ];
    };
  };
}
