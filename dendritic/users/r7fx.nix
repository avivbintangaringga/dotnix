{
  den,
  ...
}:
{
  den.homes.x86_64-linux.r7fx = {
    fullName = "R7FX";
    git = {
      userName = "avivbintangaringga";
      email = "avivbintangaringga90@gmail.com";
    };
  };

  den.aspects.r7fx = {
    includes = (with den.batteries; [
      define-user
      primary-user
    ]) ++ (with den.aspects; [
      base

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
      gaming
      office
      media-player
      tools
      editors.minimal
      editors.ide

      docker
      kvm
      waydroid

      cliphist
      playerctld

      programming

      discord
      spotify
      telegram
    ]);

    nixos = { user, ... }: {
      users.users.${user.userName} = {
        initialPassword = "123";
      };
    };
  };
}
