{
  dotnix.js = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        typescript-language-server
      ];
      programs.bun.enable = true;
    };
  };
}
