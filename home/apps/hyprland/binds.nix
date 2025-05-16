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

    directions = rec {
      h = "l";
      j = "d";
      k = "u";
      l = "r";
      left = h;
      down = j;
      up = k;
      right = l;
    };

  in [
    "$mainMod, b, exec, $browser"
    "$mainMod, c, killactive"
    "$mainMod, e, exec, $fileManager"
    "$mainMod, f, fullscreen, 0"
    "$mainMod, n, exec, $toggleNotification"
    "$mainMod, p, pin, active"
    "$mainMod, q, exec, $terminal"
    "$mainMod, s, togglespecialworkspace, magic"
    "$mainMod, t, togglesplit"
    "$mainMod, w, exec, $randomizeWallpaper"
    
    "$mainMod SHIFT, c, forcekillactive"
    "$mainMod SHIFT, f, togglefloating"
    "$mainMod SHIFT, p, pseudo"
    "$mainMod SHIFT, s, movetoworkspace, special:magic"
    "$mainMod SHIFT, w, exec, $restartBar"
    "$mainMod SHIFT, Tab, cyclenext, prev hist visible"

    "$mainMod, space, exec, $menu"
    "$mainMod, period, exec, $emojiPicker"
    "$mainMod, Tab, cyclenext, visible"
    "$mainMod, Delete, exit"

    "$mainMod, Print, exec, $screenshotFull"
    ", Print, exec, $screenshotPartial"
  ]
  ++
  (builtins.attrValues 
    (builtins.mapAttrs 
      (key: dir: "$mainMod, ${key}, movefocus, ${dir}") directions
    )
  )
  ++
  (builtins.attrValues 
    (builtins.mapAttrs 
      (key: dir: "$mainMod SHIFT, ${key}, swapwindow, ${dir}") directions
    )
  )
  ++
  (map (n: "$mainMod, ${n}, workspace, ${n}") workspaces)
  ++
  (map (n: "$mainMod SHIFT, ${n}, movetoworkspace, ${n}") workspaces)
  ;

  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  bindel = let
    resizeparams = rec {
      h = "-10 0";
      j = "0 10";
      k = "0 -10";
      l = "10 0";
      left = h;
      down = j;
      up = k;
      right = l;
    };
  in [
    ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
    ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
  ]
  ++
  (builtins.attrValues 
    (builtins.mapAttrs 
      (key: rp: "$mainMod Control, ${key}, resizeactive, ${rp}") resizeparams
    )
  )
  ++
  (builtins.attrValues 
    (builtins.mapAttrs 
      (key: rp: "$mainMod SHIFT, ${key}, moveactive, ${rp}") resizeparams
    )
  );
}
