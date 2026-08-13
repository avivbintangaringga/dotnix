{
  dotnix.docker = { user, ... }: {
    nixos = {
      networking.firewall.trustedInterfaces = [ "docker0" ];
      users.users.${user.userName}.extraGroups = [ "docker" ];
      virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
        daemon.settings = {
          dns = [ "1.1.1.1" "8.8.8.8" ];
        };
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };
    };
  };
}
