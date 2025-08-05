{ userdata, ... }:
let
  screenshotDir = "${userdata.userpath}/Screenshots";
in
{
  "$browser" = "zen-beta";
  "$terminal" = "ghostty";
  "$fileManager" = "nemo";
  "$menu" = "rofi -show drun";
  "$alternateMenu" = "gauntlet open";
  "$emojiPicker" = "rofi -config emoji -modi emoji -emoji-format {emoji} -show";

  "$mainMod" = "SUPER";

  "$toggleNotification" = "swaync-client -t -sw";
  "$restartBar" = "systemctl --user restart waybar";
  "$randomizeWallpaper" = "sh ${userdata.userpath}/.scripts/randomize-wallpaper.sh";

  "$screenshotFull" =
    "mkdir -p ${screenshotDir} && grimblast --notify --freeze copysave screen \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
  "$screenshotPartial" =
    "mkdir -p ${screenshotDir} && grimblast --notify --freeze copysave area \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
}
