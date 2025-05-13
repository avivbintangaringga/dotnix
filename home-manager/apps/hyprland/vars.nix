{ userdata, ... }:
let
  screenshotDir = "${userdata.userpath}/Screenshots";
in
{
  "$mainMod" = "SUPER";
  "$terminal" = "kitty";
  "$fileManager" = "nemo";
  "$menu" = "rofi -show drun";
  "$emojiPicker" = "rofi -modi emoji -show emoji";

  "$screenshotFull" = "mkdir -p ${screenshotDir} && grimblast copysave screen \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
  "$screenshotWindow" = "mkdir -p ${screenshotDir} && grimblast copysave active \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
  "$screenshotPartial" = "mkdir -p ${screenshotDir} && grimblast copysave area \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
}
