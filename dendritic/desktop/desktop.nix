{
  den,
  ...
}:
{
  den.aspects.desktop = {
    includes = with den.aspects; [
      qt
      gtk
      wallpaper
      cursor

      niri
    ];
  };
}
