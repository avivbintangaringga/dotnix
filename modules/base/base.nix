{
  dotnix,
  ...
}:
{
  # TODO: SPLIT
  dotnix.base.includes = with dotnix; [
    flakes
    disable-docs
    accounts-daemon
    boot
    networkmanager
    timezone
    fonts
    sudo
  ];
}
