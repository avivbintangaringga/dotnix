{
  dotnix.dankgreet = { user }: {
    nixos = {
      programs.seahorse.enable = true;
      services.displayManager = {
        autoLogin = {
          enable = true;
          user = user.userName;
        };

        dms-greeter = {
          enable = true;
          # TODO: Make this dynamic
          compositor.name = "niri";
          configFiles = [
            "/home/${user.userName}/.config/DankMaterialShell/settings.json"
          ];
          configHome = "/home/${user.userName}";
        };
      };
      users.users.${user.userName}.extraGroups = [ "greeter" ];
    };
  };
}
