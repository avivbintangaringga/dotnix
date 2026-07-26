{
  dotnix.docker = { user, ... }: {
    nixos = {
      users.users.${user.userName} = {
        extraGroups = [ "docker" ];
      };
      virtualisation.docker = {
        enable = true;
        enableOnBoot = false;
        rootless = {
          enable = true;
        };
      };
    };
  };
}
