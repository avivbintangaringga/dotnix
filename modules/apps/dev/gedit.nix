{
  dotnix.gedit.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      gedit
    ];

    xdg.mimeApps.defaultApplications = {
      "application/x-*script" = [ "org.gnome.gedit.desktop" ];
      "text/plain" = [ "org.gnome.gedit.desktop" ];
    };
  };
}
