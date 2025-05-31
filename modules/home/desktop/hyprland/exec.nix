{
  exec = [
    #"swww img /home/r7fx/.wallpapers/default.jpg"
    # "systemctl --user restart waybar"
  ];

  exec-once = [
    "sh ~/.scripts/randomize-wallpaper.sh --quiet"
  ];
}
