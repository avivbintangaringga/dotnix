{
  lib,
  myLib,
  ...
}:
{
  dotnix.archive = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        kdePackages.ark
        peazip
      ];

      xdg.mimeApps.defaultApplications = lib.mkMerge [
        (myLib.listToAttrsSameValue myLib.mimeTypes.archives [ "peazip.desktop" ])
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
