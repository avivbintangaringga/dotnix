{ userdata, ... }:
{
  services.hyprpaper = {
    enable = false;
    settings = {
      preload = "${userdata.userpath}/.wallpapers/default.jpg";
      wallpaper = ",${userdata.userpath}/.wallpapers/default.jpg";
    };
  };
}
