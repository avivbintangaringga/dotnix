{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
    mod = "SUPER";
in {
  imports = [
    inputs.mango.hmModules.mango
  ];

  options = {
    setup.desktop.mango.enable = lib.mkEnableOption "MangoWC";
  };

  config = lib.mkIf config.setup.desktop.mango.enable {
    setup.desktop.features = {
      cursor.enable = true;
      gtk.enable = true;
      wallpaper.enable = true;
    };

    wayland.windowManager.mango = {
      enable = true;
      settings = ''
          bind=${mod},e,spawn,nautilus
          bind=${mod},b,spawn,zen-beta
          bind=${mod},space,spawn,dms ipc call spotlight toggle
          bind=${mod},Return,spawn,kitty

          bind=${mod},q,killclient
          bind=${mod},s,switch_layout
          bind=${mod},r,reload_config
          bind=${mod},f,togglemaximizescreen
          bind=${mod}+SHIFT,f,togglefullscreen

          bind=${mod},Left,focusdir,left
          bind=${mod},Down,focusdir,down
          bind=${mod},Up,focusdir,up
          bind=${mod},Right,focusdir,right
          bind=${mod},h,focusdir,left
          bind=${mod},j,focusdir,down
          bind=${mod},k,focusdir,up
          bind=${mod},l,focusdir,right

          bind=${mod},Tab,focusstack,next
          bind=${mod}+SHIFT,Tab,focusstack,prev
          bind=ALT,Tab,toggleoverview

          gesturebind=none,left,3,focusdir,right
          gesturebind=none,down,3,focusdir,up
          gesturebind=none,up,3,focusdir,down
          gesturebind=none,right,3,focusdir,left

          mousebind=NONE,btn_left,toggleoverview,-1
          mousebind=NONE,btn_right,killclient,0
          mousebind=${mod},btn_left,moveresize,curmove
          mousebind=${mod},btn_right,moveresize,curresize

          axisbind=${mod},UP,focusstack,prev
          axisbind=${mod},DOWN,focusstack,next

          # Keyboard settings
          repeat_delay=300
          repeat_rate=30
          numlockon=1

          # Trackpad settings
          trackpad_natural_scrolling=1
          disable_while_typing=1
          

          blur=1
          blur_layer=0
          blur_optimized=0

          border_radius=8
          borderpx=2
          gappih=8
          gappoh=8
          gappiv=8
          gappov=8

          animations=1
          animation_type_open=fade
          animation_type_close=fade
          layer_animations=0
          layer_animation_type_open=fade
          layer_animatoin_type_close=fade

          
          hotarea_size=10
          enable_hotarea=1
          overviewgappi=8
          overviewgappo=16
          
          
          # Scroller settings
          edge_scroller_pointer_focus=0
        '';
      autostart_sh = ''
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
          /usr/lib/xdg-desktop-portal-wlr &

          dms run
        '';
    };
  };
}
