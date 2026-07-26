{
  dotnix.docker = { user, ... }: {
    nixos = {
      virtualisation.docker = {
        enable = true;
        enableOnBoot = false;
        rootless = {
          enable = true;
        };
      };

      users.users.${user.userName} = {
        extraGroups = [ "docker" ];
      };
    };
  };
}
