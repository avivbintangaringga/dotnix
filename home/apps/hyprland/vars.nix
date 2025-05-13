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

  "$restartBar" = "systemctl --user restart waybar";

  "$screenshotFull" = "mkdir -p ${screenshotDir} && grimblast --notify copysave screen \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
  "$screenshotPartial" = "mkdir -p ${screenshotDir} && grimblast --notify copysave area \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
}
