{ home, ... }:
let
  screenshotDir = "${home}/Screenshots";
in
{
  "$alternateMenu" = "gauntlet open";
  "$browser" = "zen-beta";
  "$emojiPicker" = "rofi -config emoji -modi emoji -emoji-format {emoji} -show";
  "$fileManager" = "nautilus";
  "$mainMod" = "SUPER";
  "$menu" = "vicinae toggle";
  "$randomizeWallpaper" = "sh ${home}/.scripts/randomize-wallpaper.sh -a";
  "$restartBar" = "systemctl --user restart waybar";

  "$screenshotFull" =
    "mkdir -p ${screenshotDir} && grimblast --notify --freeze copysave screen \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";

  "$screenshotPartial" =
    "mkdir -p ${screenshotDir} && grimblast --notify --freeze copysave area \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";

  "$terminal" = "kitty";
  "$toggleNotification" = "swaync-client -t -sw";
}
