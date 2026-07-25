{
  den,
  ...
}:
{
  # TODO: SPLIT
  den.aspects.tools = {
    includes = with den.aspects; [
      adb
      archive
      git
      monitoring
    ];
  };
}
