{
  den,
  ...
}:
{
  den.aspects.base = {
    includes = with den.aspects; [
      flakes
      accounts-daemon
      boot
      networkmanager
      timezone
    ];
  };
}
