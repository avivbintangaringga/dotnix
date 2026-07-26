{
  dotnix,
  ...
}:
{
  dotnix.desktop = {
    includes = with dotnix; [
      qt
      gtk
      wallpaper
      cursor
      xdg

      niri
    ];
  };
}
