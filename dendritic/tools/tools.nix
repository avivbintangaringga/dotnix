{
  den,
  ...
}:
{
  # TODO: SPLIT
  den.aspects.tools = {
    includes = with den.aspects; [
      adb
      archive
      git
      monitoring
    ];

    nixos = { pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        fastfetch
        wget
        curl
        killall
        tree
        xxd
        usbutils
        inetutils
        vlan
        nfs-utils
        efibootmgr
      ];
    };
  };
}
