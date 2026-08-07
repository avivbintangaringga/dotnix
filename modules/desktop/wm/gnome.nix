{
  dotnix.gnome = {
    nixos = { pkgs, ... }: {
      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-user-docs
      ];
      services = {
        desktopManager.gnome.enable = true;
        gnome = {
          core-apps.enable = false;
          core-developer-tools.enable = false;
          games.enable = false;
        };
      };
    };
  };
}
