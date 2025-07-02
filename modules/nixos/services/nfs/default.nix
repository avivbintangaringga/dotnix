{ lib, config, ... }:
{
  options = {
    setup.services.nfs.enable = lib.mkEnableOption "NFS Server";
  };

  config = lib.mkIf config.setup.services.nfs.enable {
    fileSystems = {
      "/NFS-SHARE/DATA" = {
        device = "/media/DATA";
        options = [ "bind" ];
      };
    };

    services = {
      nfs.server = {
        enable = true;
        exports = ''
          /NFS-SHARE        192.168.122.199(rw,fsid=0,no_subtree_check)
          /NFS-SHARE/DATA   192.168.122.199(rw,nohide,insecure,no_subtree_check)
        '';
      };
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 2049 ];
    };
  };
}
