{
  den.aspects.sl = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        cmatrix
      ];
    };

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        sl
      ];
    };
  };
}
