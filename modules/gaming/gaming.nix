{
  dotnix,
  ...
}:
{
  dotnix.gaming = {
    includes = with dotnix; [
      faugus
      gamemode
      gamescope
      lact
      lsfg-vk
      mangohud
      proton
      steam
    ];
  };
}
