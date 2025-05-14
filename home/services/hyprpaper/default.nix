{ userdata, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${userdata.userpath}/.wallpapers/default.jpg";
      wallpaper = ",${userdata.userpath}/.wallpapers/default.jpg";
    };
  };
}
