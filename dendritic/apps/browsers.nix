{
  den,
  ...
}:
{
  den.aspects.browsers = {
    includes = with den.aspects; [
      thorium
      zen-browser
    ];
  };
}
