{
  dotnix.adb.nixos = { user, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      android-tools
    ];

    users.users.${user.userName}.extraGroups = [ "adbuser" ];
  };
}
