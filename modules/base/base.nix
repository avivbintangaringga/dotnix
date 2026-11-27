{
  dotnix,
  ...
}:
{
  # TODO: SPLIT
  dotnix.base.includes = with dotnix; [
    my-packages
    flakes
    disable-docs
    accounts-daemon
    boot
    networkmanager
    timezone
    fonts
    sudo
    zram
  ];
}
