# NixOS module for the repackaged Droidloom.
#   imports = [ ./module.nix ];
#   programs.droidloom = { enable = true; users = [ "youruser" ]; };
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.droidloom;
  pkg = cfg.package;
  rt = pkg.runtime;

  hostBins = [
    "droidloomd"
    "droidloomctl"
    "droidloom-applications"
    "droidloom-audio"
    "droidloom-devices"
    "droidloom-doctor"
    "droidloom-gpu-server"
    "droidloom-supervisor"
    "droidloom-wayland"
  ];

  # tools the binaries spawn by name (ip, mount, unshare, tar, zstd, rsync, ...)
  toolPath = with pkgs; [
    iproute2
    util-linux
    gnutar
    zstd
    nftables
    iptables
    e2fsprogs
    coreutils
    android-tools
    rsync
    config.systemd.package
    glibc.bin
  ];

  # Tools the prebuilt binaries exec by hardcoded absolute path. These cannot be
  # patched to store paths, so expose them under /usr/bin. pkexec must be the
  # setuid wrapper, otherwise `droidloomctl start` cannot run package setup.
  compatBins = {
    adb = "${pkgs.android-tools}/bin/adb";
    getent = "${pkgs.getent}/bin/getent";
    nsenter = "${lib.getBin pkgs.util-linux}/bin/nsenter";
    pkexec = "${config.security.wrapperDir}/pkexec";
    runuser = "${lib.getBin pkgs.util-linux}/bin/runuser";
    systemctl = "${config.systemd.package}/bin/systemctl";
    systemd-run = "${config.systemd.package}/bin/systemd-run";
    timeout = "${pkgs.coreutils}/bin/timeout";
  };
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkg ]; # also exposes the polkit action
    security.polkit.enable = true;
    security.polkit.enablePkexecWrapper = lib.mkDefault true;
    # The package helper also writes /etc/polkit-1/rules.d/49-droidloom.rules at
    # setup time; declare the equivalent rule here too so cfg.users works from
    # the first boot and if /etc is reset.
    security.polkit.extraConfig = lib.concatMapStrings (u: ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.systemd1.manage-units" &&
            subject.user == "${u}" &&
            action.lookup("unit") === "droidloomd.service" &&
            (action.lookup("verb") === "start" || action.lookup("verb") === "stop"))
          return polkit.Result.YES;
      });
    '') cfg.users;
    systemd.packages = [ rt ]; # system + user units
    systemd.services.droidloomd = {
      path = toolPath;
      wantedBy = [ "multi-user.target" ];
    };
    # The binaries hardcode /usr/bin/*, /usr/lib/droidloom, /usr/share/droidloom
    # (cell-template.json, package.json), and we can't recompile, so provide those paths.
    systemd.tmpfiles.rules = [
      "d /usr/bin 0755 root root -"
      "d /usr/lib 0755 root root -"
      "d /usr/share 0755 root root -"
      "L+ /usr/lib/droidloom - - - - ${pkg}/lib/droidloom"
      "L+ /usr/share/droidloom - - - - ${pkg}/share/droidloom"
    ]
    ++ lib.mapAttrsToList (n: t: "L+ /usr/bin/${n} - - - - ${t}") compatBins
    ++ map (b: "L+ /usr/bin/${b} - - - - ${rt}/bin/${b}") hostBins;
    systemd.user.services = {
      droidloom = {
        path = toolPath;
        wantedBy = [ "graphical-session.target" ];
      };
      droidloom-applications.path = toolPath;
      droidloom-audio.path = toolPath;
      droidloom-devices.path = toolPath;
      droidloom-gpu.path = toolPath;
      droidloom-recovery.path = toolPath;
    };
  };
  options.programs.droidloom = {
    enable = lib.mkEnableOption "Droidloom (Android apps in native Wayland windows)";
    package = lib.mkOption {
      default = pkgs.callPackage ./_package.nix { };
      type = lib.types.package;
    };
    users = lib.mkOption {
      default = [ ];
      description = "Desktop users allowed to start/stop droidloomd.service without a password.";
      type = lib.types.listOf lib.types.str;
    };
  };
}
