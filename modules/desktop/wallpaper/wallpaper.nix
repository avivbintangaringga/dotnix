{
  self,
  ...
}:
{
  dotnix.wallpaper = {
    homeManager = { home, ... }: {
      home = {
        file = {
          "/home/${home.userName}/.wallpapers" = {
            enable = true;
            source = self + "/assets/wallpapers";
            recursive = true;
            force = true;
          };
        };
      };
    };
  };
}
