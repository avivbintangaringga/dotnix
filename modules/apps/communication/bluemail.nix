{
  dotnix.bluemail = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        bluemail
      ];
    };
  };
}
