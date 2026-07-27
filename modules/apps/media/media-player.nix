{
  lib,
  myLib,
  ...
}:
{
  dotnix.media-player.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      kdePackages.gwenview
      vlc
    ];

    xdg.mimeApps.defaultApplications = lib.mkMerge [
      (myLib.listToAttrsSameValue myLib.mimeTypes.videos [ "vlc.desktop" ])
      (myLib.listToAttrsSameValue myLib.mimeTypes.audios [ "vlc.desktop" ])
      (myLib.listToAttrsSameValue myLib.mimeTypes.images [ "org.kde.gwenview.desktop" ])
    ];
  };
}
