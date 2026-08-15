{
  dotnix.docker = { user, ... }: {
    nixos = { pkgs, ... }: {
      networking.firewall.trustedInterfaces = [ "docker0" ];
      security.wrappers = {
        docker-rootlesskit = {
          owner = "root";
          group = "root";
          capabilities = "cap_net_bind_service+ep";
          source = "${pkgs.rootlesskit}/bin/rootlesskit";
        };
      };
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
