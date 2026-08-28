{
  dotnix.anydesk = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        anydesk
      ];
    };
  };
}
