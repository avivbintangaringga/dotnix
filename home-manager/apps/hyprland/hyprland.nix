{ lib, pkgs, userdata, ... }: 
let
  mainMod = "SUPER";
  terminal = "kitty";
  fileManager = "nemo";
  menu = "rofi -show drun";
  emojiPicker = "rofi -modi emoji -show emoji";

  screenshotDir = "${userdata.userpath}/Screenshots";
  screenshotFull = "mkdir -p ${screenshotDir} && grimblast copysave screen \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
  screenshotPartial = "mkdir -p ${screenshotDir} && grimblast copysave area \"${screenshotDir}/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"";
in
{
   wayland.windowManager.hyprland = {
     enable = true;
     package = pkgs.hyprland;
     xwayland.enable = true;
     settings = {
       monitor = ",1920x1080@144,auto,1";
       env = [
         "XCURSOR_SIZE,24"
         "HYPRCURSOR_SIZE,24"
       ];
       general = {
         gaps_in = 4;
         gaps_out = 8;
       };
       input = {
         kb_layout = "us";
         follow_mouse = "1";
         sensitivity = "0";
         touchpad = {
           natural_scroll = true;
         };
       };
       bind = let
         workspaces = [
           "0"
           "1"
           "2"
           "3"
           "4"
           "5"
           "6"
           "7"
           "8"
           "9"
         ];
       in [
         "${mainMod}, Q, exec, ${terminal}"
         "${mainMod}, C, killactive"
         "${mainMod}, M, exit"
         "${mainMod}, E, exec, ${fileManager}"
	 "${mainMod}, SPACE, exec, ${menu}"
	 "${mainMod}, period, exec, ${emojiPicker}"

         "${mainMod}, S, togglespecialworkspace, magic"
         "${mainMod} SHIFT, S, movetoworkspace, special:magic"

         "${mainMod}, h, movefocus, l"
         "${mainMod}, j, movefocus, d"
         "${mainMod}, k, movefocus, u"
         "${mainMod}, l, movefocus, r"

         "${mainMod}, Print, exec, ${screenshotFull}"
         ", Print, exec, ${screenshotPartial}"
       ]
       ++
       (map (n: "${mainMod}, ${n}, workspace, ${n}") workspaces)
       ++
       (map (n: "${mainMod} SHIFT, ${n}, movetoworkspace, ${n}") workspaces)
       ;

       bindm = [
           "${mainMod}, mouse:272, movewindow"
           "${mainMod}, mouse:273, resizewindow"
       ];

       bindel = [

       ];
     };
   };
}
