{
  den.aspects.js = {
    homeManager = { pkgs, ... }: {
      programs.bun.enable = true;
      home.packages = with pkgs; [
        typescript-language-server
      ];
    };
  };
}
