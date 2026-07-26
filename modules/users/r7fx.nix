{
  den,
  dotnix,
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
    ]) ++ (with dotnix; [
      base

      valent
      nautilus
      winbox
      cloudflare-warp

      flatpak

      zsh

      nv-switch

      desktop
      browsers
      code-editors.minimal
      code-editors.ide
      downloaders
      image-editors
      gaming
      office
      media-player
      tools

      docker
      kvm
      waydroid

      cliphist
      playerctld

      programming

      discord
      ferdium
      spotify
      telegram

      kitty
      obs-studio

      bruno
      dbeaver
    ]);

    nixos = { user, ... }: {
      users.users.${user.userName} = {
        initialPassword = "123";
      };
    };
  };
}
