{
  dotnix.docker = { user, ... }: {
    nixos = { pkgs, ... }: {
      networking.firewall.trustedInterfaces = [ "docker0" ];
      security.wrappers.docker-rootlesskit = {
        capabilities = "cap_net_bind_service+ep";
        group = "root";
        owner = "root";
        source = "${pkgs.rootlesskit}/bin/rootlesskit";
      };
      users.users.${user.userName}.extraGroups = [ "docker" ];
      virtualisation.docker = {
        enable = true;
        daemon.settings.dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        enableOnBoot = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };
    };
  };
}
