{
  dotnix,
  ...
}:
{
  # TODO: SPLIT
  dotnix.tools = {
    includes = with dotnix; [
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

        btrfs-assistant

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
