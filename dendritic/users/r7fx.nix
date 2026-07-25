{
  den,
  ...
}:
{
  den.homes.x86_64-linux.r7fx = { };

  den.aspects.r7fx = {
    includes = (with den.batteries; [
      define-user
      primary-user
    ]) ++ (with den.aspects; [
      valent
      nautilus
      steam
      winbox
      cloudflare-warp

      vfio
      docker
    ]);
  };
}
