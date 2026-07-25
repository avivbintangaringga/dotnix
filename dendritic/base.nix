{
  den,
  ...
}:
{
  den.aspects.base = {
    includes = with den.aspects; [
      accounts-daemon
    ];
  };
}
