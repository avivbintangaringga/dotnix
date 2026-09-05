{
  dotnix,
  ...
}:
{
  # TODO: SPLIT
  dotnix.tools = {
    homeManager = { pkgs, ... }: {
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

        jq
        yt-dlp
        mpv
      ];
    };
    includes = with dotnix; [
      adb
      archive
      git
      home-manager
      monitoring
      mise
      nh
    ];
    nixos = { pkgs, ... }: {
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
