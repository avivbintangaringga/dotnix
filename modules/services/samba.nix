{
  dotnix.samba = {
    nixos = { user, ... }: {
      fileSystems = {
        "/SAMBA-SHARE/DATA" = {
          options = [ "bind" ];
          device = "/media/DATA";
        };
      };
      networking.firewall = {
        enable = true;
      };
      services = {
        samba = {
          enable = true;
          openFirewall = true;
          settings = {
            global = {
              "map to guest" = "Bad Password";
              "max log size" = "1000";
              "security" = "user";
              "server role" = "standalone server";
              "workgroup" = "WORKGROUP";
            };
            "vm-win11" = {
              "browsable" = "yes";
              "create mask" = "0644";
              "directory mask" = "0755";
              "force user" = "${user.userName}";
              "guest ok" = "no";
              "path" = "/SAMBA-SHARE";
              "writable" = "yes";
            };
          };
        };
      };
    };
  };
}
