{
  dotnix.dankgreet = { user }: {
    nixos = {
      services.displayManager = {
        autoLogin = {
          enable = true;
          user = user.userName;
        };

        dms-greeter = {
          enable = true;
          # TODO: Make this dynamic
          compositor.name = "niri";
          configHome = "/home/${user.userName}";
          configFiles = [
            "/home/${user.userName}/.config/DankMaterialShell/settings.json"
          ];
        };
      };

      programs.seahorse.enable = true;

      users.users.${user.userName} = {
        extraGroups = [ "greeter" ];
      };
    };
  };
}
