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
            force = true;
            recursive = true;
            source = self + "/assets/wallpapers";
          };
        };
      };
    };
  };
}
