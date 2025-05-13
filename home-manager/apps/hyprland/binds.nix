{
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
    "$mainMod, Q, exec, $terminal"
    "$mainMod, C, killactive"
    "$mainMod, M, exit"
    "$mainMod, E, exec, $fileManager"
    "$mainMod, SPACE, exec, $menu"
    "$mainMod, period, exec, $emojiPicker"

    "$mainMod, S, togglespecialworkspace, magic"
    "$mainMod SHIFT, S, movetoworkspace, special:magic"

    "$mainMod, h, movefocus, l"
    "$mainMod, j, movefocus, d"
    "$mainMod, k, movefocus, u"
    "$mainMod, l, movefocus, r"
    "$mainMod, left, movefocus, l"
    "$mainMod, down, movefocus, d"
    "$mainMod, up, movefocus, u"
    "$mainMod, right, movefocus, r"

    "$mainMod, Print, exec, $screenshotFull"
    "$mainMod SHIFT, Print, exec, $screenShotWindow"
    ", Print, exec, $screenshotPartial"
  ]
  ++
  (map (n: "$mainMod, ${n}, workspace, ${n}") workspaces)
  ++
  (map (n: "$mainMod SHIFT, ${n}, movetoworkspace, ${n}") workspaces)
  ;

  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  bindel = [

  ];
}
