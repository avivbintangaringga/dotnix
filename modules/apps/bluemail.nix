{
  den.aspects.bluemail = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        bluemail
      ];
    };
  };
}
