{
  den,
  ...
}:
{
  # TODO: SPLIT
  den.aspects.base = {
    includes = with den.aspects; [
      flakes
      disable-docs
      accounts-daemon
      boot
      networkmanager
      timezone
      fonts
    ];
  };
}
