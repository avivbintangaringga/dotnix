{
  bind =
    let
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

      directions = rec {
        down = j;
        h = "l";
        j = "d";
        k = "u";
        l = "r";
        left = h;
        right = l;
        up = k;
      };

    in
    [
      "$mainMod, b, exec, $browser"
      "$mainMod, q, killactive"
      "$mainMod, e, exec, $fileManager"
      "$mainMod, f, fullscreen, 0"
      "$mainMod, n, exec, $toggleNotification"
      "$mainMod, p, pin, active"
      "$mainMod, return, exec, $terminal"
      "$mainMod, s, togglespecialworkspace, magic"
      "$mainMod, t, togglesplit"
      # "$mainMod, w, exec, $randomizeWallpaper"

      "$mainMod SHIFT, q, forcekillactive"
      "$mainMod SHIFT, f, togglefloating"
      "$mainMod SHIFT, p, pseudo"
      "$mainMod SHIFT, s, movetoworkspace, special:magic"
      # "$mainMod SHIFT, w, exec, $restartBar"
      "$mainMod SHIFT, Tab, cyclenext, prev hist visible"

      "$mainMod, space, exec, $menu"
      # "$mainMod ALT, space, exec, $alternateMenu"
      "$mainMod, period, exec, $emojiPicker"
      "$mainMod, Tab, cyclenext, visible"
      "$mainMod, Delete, exit"

      # Screenshot
      "$mainMod, Print, exec, $screenshotFull"
      ", Print, exec, $screenshotPartial"

      # Audio related
      ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"

      # Playerctl
      "$mainMod ALT, left, exec, swayosd-client --playerctl prev"
      "$mainMod ALT, right, exec, swayosd-client --playerctl next"
      "$mainMod ALT, up, exec, swayosd-client --playerctl play-pause"
      "$mainMod ALT, down, exec, swayosd-client --playerctl play-pause"
    ]
    ++ (builtins.attrValues (
      builtins.mapAttrs (key: dir: "$mainMod, ${key}, movefocus, ${dir}") directions
    ))
    ++ (builtins.attrValues (
      builtins.mapAttrs (key: dir: "$mainMod SHIFT, ${key}, swapwindow, ${dir}") directions
    ))
    ++ (map (n: "$mainMod, ${n}, workspace, ${n}") workspaces)
    ++ (map (n: "$mainMod SHIFT, ${n}, movetoworkspace, ${n}") workspaces);

  bindel =
    let
      resizeparams = rec {
        down = j;
        h = "-10 0";
        j = "0 10";
        k = "0 -10";
        l = "10 0";
        left = h;
        right = l;
        up = k;
      };
    in
    [
      # ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      # ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      # ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      # ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      # ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      # ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"

      ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
      ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
      ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
      ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
    ]
    ++ (builtins.attrValues (
      builtins.mapAttrs (key: rp: "$mainMod Control, ${key}, resizeactive, ${rp}") resizeparams
    ))
    ++ (builtins.attrValues (
      builtins.mapAttrs (key: rp: "$mainMod SHIFT, ${key}, moveactive, ${rp}") resizeparams
    ));

  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  bindr = [
    "CAPS, Caps_Lock, exec, swayosd-client --caps-lock"
  ];

  binds.hide_special_on_workspace_change = true;
}
