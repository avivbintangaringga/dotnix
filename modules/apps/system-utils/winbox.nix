{
  self,
  ...
}:
{
  dotnix.winbox = {
    homeManager = { pkgs, ... }: {
      xdg.desktopEntries.winbox = {
        exec = "${pkgs.winbox4}/bin/WinBox";
        icon = self + "/assets/icons/winbox.png";
        name = "WinBox";
        terminal = false;
        type = "Application";
      };
    };

    nixos = { pkgs, ... }: {
      programs.winbox = {
        enable = true;
        package = pkgs.winbox4;
        openFirewall = true;
      };
    };
  };
}
