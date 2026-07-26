{
  dotnix.vicinae = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        vicinae
      ];
    };
  };
}
