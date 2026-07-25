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

      lsfg-vk
      flatpak

      zsh
      scripts.nv-switch
      scripts.vm

      desktop

      docker
      kvm
      waydroid
    ]);

    nixos = { user, ... }: {
      users.users.${user.userName} = {
        initialPassword = "123";
      };
    };
  };
}
