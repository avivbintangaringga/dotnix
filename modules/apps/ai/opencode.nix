{
  dotnix.opencode = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        opencode
      ];
    };
  };
}
