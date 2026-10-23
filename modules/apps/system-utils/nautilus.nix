{
  dotnix,
  ...
}:
{
  dotnix.nautilus = {
    homeManager.xdg.mimeApps.defaultApplications."inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    includes = with dotnix; [
      nautilus-computer
    ];
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        nautilus
      ];

      programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "kitty";
      };
    };
  };
}
