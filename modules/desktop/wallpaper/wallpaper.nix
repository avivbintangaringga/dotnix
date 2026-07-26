{
  flake-root,
  ...
}:
{
  dotnix.wallpaper = {
    homeManager = { pkgs, home, ... }: {
      # TODO: make script into writeShellScript
      home = {
        packages = with pkgs; [
          jq
        ];

        file = {
          "/home/${home.userName}/.wallpapers" = {
            enable = true;
            source = flake-root + "/assets/wallpapers";
            recursive = true;
            force = true;
          };

          "/home/${home.userName}/.scripts" = {
            enable = true;
            source = ./scripts;
            executable = true;
            recursive = true;
          };
        };
      };
    };
  };
}
