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
    "$mainMod, q, exec, $terminal"
    "$mainMod, b, exec, $browser"
    "$mainMod, w, exec, $restartBar"
    "$mainMod, c, killactive"
    "$mainMod, Delete, exit"
    "$mainMod, e, exec, $fileManager"
    "$mainMod, f, togglefloating"
    "$mainMod, t, togglesplit"
    "$mainMod, space, exec, $menu"
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
    ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
    ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
  ];
}
