{
  den.aspects.proton = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        protonplus
        winetricks
        umu-launcher
      ];
    };
  };
}
