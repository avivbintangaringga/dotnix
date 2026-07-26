{
  self,
  ...
}:
{
  dotnix.winbox = {
    homeManager = { pkgs, ...}: {
      xdg.desktopEntries.winbox = {
        name = "WinBox";
        exec = "${pkgs.winbox4}/bin/WinBox";
        icon = self + "/assets/icons/winbox.png";
        type = "Application";
        terminal = false;
      };
    };

    nixos = { pkgs, ... }: {
      programs.winbox = {
        enable = true;
        openFirewall = true;
        package = pkgs.winbox4;
      };
    };
  };
}
