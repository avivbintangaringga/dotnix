{ userdata, ... }:
let
  screenshotDir = "${userdata.userpath}/Screenshots";
in
{
  "$browser" = "zen-beta";
  "$terminal" = "kitty";
  "$fileManager" = "nemo";
  "$menu" = "rofi -show drun";
  "$emojiPicker" = "rofi -modi emoji -show emoji";

  "$mainMod" = "SUPER";

  "$toggleNotification" = "swaync-client -t -sw";
  "$restartBar" = "systemctl --user restart waybar";
  "$randomizeWallpaper" = "sh ${userdata.userpath}/.scripts/randomize-wallpaper.sh && notify-send 'Wallpaper changed'";

  "$screenshotFull" = "mkdir -p ${screenshotDir} && grimblast --notify copysave screen \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
  "$screenshotPartial" = "mkdir -p ${screenshotDir} && grimblast --notify copysave area \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
}
