{
  den.aspects.archive = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        kdePackages.ark
        peazip
      ];
    };

    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        zip
        unzip
        p7zip
        unrar
      ];
    };
  };
}
