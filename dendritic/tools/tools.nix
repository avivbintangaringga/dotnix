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
      home-manager
      monitoring
      mise
      nh
    ];

    homeManager = { pkgs, ...}: {
      # TODO: SPLIT
      home.packages = with pkgs; [
        rclone
        wev
        cava

        lsof
        gnumake

        tailwindcss_4
        watchman

        scrcpy
      ];
    };

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
