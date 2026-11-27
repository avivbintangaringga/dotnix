{
  dotnix.youtube = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        ytm-rs
        streamtube
      ];
    };
  };
}
