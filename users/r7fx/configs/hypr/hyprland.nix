{lib, ...}: 
let
  mainMod = "SUPER";
  terminal = "kitty";
  fileManager = "dolphin";
in
{
   wayland.windowManager.hyprland.settings = {
     monitor = ",1920x1080@144,auto,1";
     env = [
       "XCURSOR_SIZE,24"
       "HYPRCURSOR_SIZE,24"
     ];
     general = {
       gaps_in = 5;
       gaps_out = 10;
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

       "${mainMod}, S, togglespecialworkspace, magic"
       "${mainMod} SHIFT, S, movetoworkspace, special:magic"

       "${mainMod}, h, movefocus, l"
       "${mainMod}, j, movefocus, d"
       "${mainMod}, k, movefocus, u"
       "${mainMod}, l, movefocus, r"
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
}
