{
  dotnix,
  inputs,
  ...
}:
{
  flake-file.inputs.mango = {
    url = "github:DreamMaoMao/mango";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.mango = {
    includes = with dotnix; [
      noctalia
      vicinae
    ];

    homeManager = { pkgs, ... }: {
      imports = [
        inputs.mango.hmModules.mango
      ];
      wayland.windowManager.mango =
        let
          mod = "SUPER";
          axisMove = {
            down = "up";
            left = "right";
            right = "left";
            up = "down";
          };
          directions = rec {
            down = j;
            h = "left";
            j = "down";
            k = "up";
            l = "right";
            left = h;
            right = l;
            up = k;
          };
        in
        {
          enable = true;
          autostart_sh = ''
            /usr/lib/xdg-desktop-portal-wlr &

            noctalia &
            vicinae server &
          '';
          settings = {
            animation_type_close = "fade";
            animation_type_open = "fade";
            animations = 1;
            axisbind = [
              "${mod},UP,focusstack,prev"
              "${mod},DOWN,focusstack,next"
            ];
            bind = [
              "${mod},e,spawn,nautilus"
              "${mod},b,spawn,zen-beta"
              "${mod},space,spawn,vicinae toggle"
              "${mod},Return,spawn,kitty"
              "${mod},q,killclient"
              "${mod}+SHIFT,q,killclient,force"
              "${mod},s,switch_layout"
              "${mod},r,reload_config"
              "${mod},f,togglemaximizescreen"
              "${mod}+SHIFT,f,togglefullscreen"
              # "${mod},Left,focusdir,left"
              # "${mod},Down,focusdir,down"
              # "${mod},Up,focusdir,up"
              # "${mod},Right,focusdir,right"
              # "${mod},h,focusdir,left"
              # "${mod},j,focusdir,down"
              # "${mod},k,focusdir,up"
              # "${mod},l,focusdir,right"
              "${mod},Tab,focusstack,next"
              "${mod}+SHIFT,Tab,focusstack,prev"
              "ALT,Tab,toggleoverview"
              "${mod},o,toggleoverlay"
              "${mod}+CTRL,f,togglefloating"
            ]
            ++ (builtins.attrValues (
              builtins.mapAttrs (key: dir: "${mod},${key},focus_window_or_workspace,${dir}") directions
            ))
            ++ (builtins.attrValues (
              builtins.mapAttrs (key: dir: "${mod}+SHIFT,${key},exchange_client,${dir}") directions
            ));
            blur = 1;
            blur_layer = 0;
            blur_optimized = 0;
            border_radius = 8;
            borderpx = 2;
            disable_while_typing = 1;
            # Scroller settings
            edge_scroller_pointer_focus = 0;
            enable_hotarea = 1;
            exec-once = [

            ];
            gappih = 8;
            gappiv = 8;
            gappoh = 8;
            gappov = 8;
            gesturebind = (
              builtins.attrValues (
                builtins.mapAttrs (move: dir: "none,${move},3,focus_window_or_workspace,${dir}") axisMove
              )
            );
            hotarea_corner = 0;
            hotarea_size = 10;
            layer_animation_type_close = "fade";
            layer_animation_type_open = "fade";
            layer_animations = 0;
            mousebind = [
              "${mod},btn_left,moveresize,curmove"
              "${mod},btn_right,moveresize,curresize"
            ];
            numlockon = 1;
            ov_no_resize = 1;
            overviewgappi = 8;
            overviewgappo = 8;
            repeat_delay = 300;
            repeat_rate = 30;
            tag_animation_direction = 0;
            trackpad_natural_scrolling = 1;
          }
          // (
            if inputs ? noctalia then
              {
                source-optional = [
                  "./noctalia.conf"
                ];
              }
            else
              { }
          );
        };
      xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
    };

    nixos = {
      imports = [
        inputs.mango.nixosModules.mango
      ];

      programs.mango.enable = true;
    };
  };
}
