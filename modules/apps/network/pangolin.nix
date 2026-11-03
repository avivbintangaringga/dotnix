{
  dotnix.pangolin = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        pangolin-cli
      ];
    };
  };
}
