{
  den.aspects.adb = {
    nixos = { pkgs, user, ... }: {
      environment.systemPackages = with pkgs; [
        android-tools
      ];

      users.users.${user.userName} = {
        extraGroups = [ "adbuser" ];
      };
    };
  };
}
