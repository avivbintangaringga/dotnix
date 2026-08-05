{
  dotnix.netbeans = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        jre
        netbeans
      ];
    };
  };
}
