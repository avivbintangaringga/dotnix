{ lib, config, ... }:
{
  options = {
    setup.services.nfs.enable = lib.mkEnableOption "NFS Server";
  };

  config = lib.mkIf config.setup.services.nfs.enable {
    # fileSystems = {
    #   "/NFS-SHARE/DATA" = {
    #     device = "/media/DATA";
    #     options = [ "bind" ];
    #   };
    # };

    services = {
      nfs.server = {
        enable = true;
        exports = ''
          /NFS-SHARE        *(rw,fsid=root)
          /NFS-SHARE/DATA   *(rw,insecure)
        '';
      };
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 2049 ];
      allowedUDPPorts = [ 2049 ];
    };
  };
}
