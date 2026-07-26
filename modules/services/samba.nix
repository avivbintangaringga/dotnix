{
  den.aspects.samba = {
    nixos = { user, ... }: {
      fileSystems = {
        "/SAMBA-SHARE/DATA" = {
          device = "/media/DATA";
          options = [ "bind" ];
        };
      };

      services = {
        samba = {
          enable = true;
          openFirewall = true;
          settings = {
            global = {
              "workgroup" = "WORKGROUP";
              "security" = "user";
              "max log size" = "1000";
              "server role" = "standalone server";
              "map to guest" = "Bad Password";
            };
            "vm-win11" = {
              "path" = "/SAMBA-SHARE";
              "writable" = "yes";
              "browsable" = "yes";
              "guest ok" = "no";
              "create mask" = "0644";
              "directory mask" = "0755";
              "force user" = "${user.userName}";
            };
          };
        };
      };

      networking.firewall = {
        enable = true;
      };
    };
  };
}
