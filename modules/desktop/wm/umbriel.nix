{
  dotnix,
  inputs,
  ...
}:
{
  dotnix.umbriel = {
    includes = with dotnix; [
      noctalia
      vicinae
    ];
    
    homeManager = { pkgs, ... }: {
      imports = [
        inputs.umbriel.homeModules.default
      ];

      nixpkgs.overlays = [
        inputs.umbriel.overlays.default
        inputs.xdg-desktop-portal-umbriel.overlays.default
      ];

      xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal-umbriel
        xdg-desktop-portal-gtk
      ];

      programs.umbriel = {
        enable = true;
        settings = {
          animation = {
            curve = "easeout";
            duration_ms = 200;
            enabled = true;
            windows_in = {
              style = "zoom";
              duration_ms = 130;
            };
            windows_out = {
              style = "slide";
              duration_ms = 130;
            };
            scratchpad = {
              enabled = true;
              blur = true;
            };
          };
          appearance = {
            blur = {
              enabled = true;
              noise = 0.02;
              optimized = false;
              passes = 2;
              radius = 3;
              saturation = 1.0;
            };
            border_width = 2;
            corner_radius = 8;
            prefer_no_csd = true;
          };
          environment = {
            QT_QPA_PLATFORMTHEME = "qtengine";
          };
          general = {
            autostart = [
              "noctalia"
              "vicinae server"
              "valent --gapplication-service"
            ];
            focus_on_activate = true;
            honor_restored_maximize = true;
            mod_key = "Super";
            show_cheatsheet = false;
            xwayland = true;
          };
          hot_corners = {
            top_left = {
              action = "overview-toggle";
              delay_ms = 0;
              enabled = true;
            };
          };
          include.files = [
            "noctalia.toml"
          ];
          input = {
            keyboard = {
              repeat_delay = 300;
              repeat_rate = 35;
            };
            middle_click_paste = true;
            touchpad = {
              natural_scroll = true;
              tap = true;
            };
          };
          keybinds = {
            "Alt+Space" = "spawn:vicinae toggle";
            "Mod+B" = "spawn:zen-beta";
            "Mod+Ctrl+Down" = "window-move-or-workspace-down";
            "Mod+Ctrl+F" = "window-toggle-maximize-to-edges";
            "Mod+Ctrl+H" = "window-move-or-output-left";
            "Mod+Ctrl+J" = "window-move-or-workspace-down";
            "Mod+Ctrl+K" = "window-move-or-workspace-up";
            "Mod+Ctrl+L" = "window-move-or-output-right";
            "Mod+Ctrl+Left" = "window-move-or-output-left";
            "Mod+Ctrl+Right" = "window-move-or-output-right";
            "Mod+Ctrl+Up" = "window-move-or-workspace-up";
            "Mod+Ctrl+V" = "window-toggle-floating";
            "Mod+Down" = "window-focus-or-workspace-down";
            "Mod+E" = "spawn:nautilus";
            "Mod+F" = "window-toggle-maximize";
            "Mod+H" = "window-focus-or-output-left";
            "Mod+J" = "window-focus-or-workspace-down";
            "Mod+K" = "window-focus-or-workspace-up";
            "Mod+L" = "window-focus-or-output-right";
            "Mod+Left" = "window-focus-or-output-left";
            "Mod+O" = "overview-toggle";
            "Mod+P" = "window-toggle-pinned";
            "Mod+Period" = "spawn:vicinae deeplink vicinae://launch/core/search-emojis";
            "Mod+Q" = "window-close";
            "Mod+R" = "window-cycle-width";
            "Mod+Return" = "spawn:kitty";
            "Mod+Right" = "window-focus-or-output-right";
            "Mod+S" = "scratchpad-toggle";
            "Mod+Shift+S" = "window-toggle-scratchpad";
            "Mod+Shift+F" = "window-toggle-fullscreen";
            "Mod+Shift+R" = "window-cycle-height";
            "Mod+Shift+V" = "window-focus-switch-floating";
            # TODO: AUDIO binds
            "Mod+Space" = "spawn:vicinae toggle";
            "Mod+Tab" = "scratchpad-focus-next";
            "Mod+Up" = "window-focus-or-workspace-up";
            "Mod+V" = "spawn:vicinae deeplink vicinae://launch/clipboard/history";
            "Mod+Z" = "spawn:zeditor";
            # TODO: Screenshot
          };
          layer_rule = [
            {
              blur = true;
              blur_ignore_alpha = 0.5;
              blur_optimized = false;
              match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
            }
            {
              blur = true;
              blur_ignore_alpha = 0.5;
              blur_optimized = false;
              match.namespace = "^vicinae$";
            }
          ];
          layout = {
            gap = 8;
            mode = "scrolling";
            scrolling = {
              center_focused = false;
              center_underfull_strip = true;
              default_width_fraction = 0.5;
              expand_single_column = true;
            };
            width_presets = [
              0.333
              0.5
              0.667
              1.0
            ];
          };
          window_rule = [
            {
              blur = true;
              blur_optimized = false;
            }
            {
              default_maximize_to_edges = true;
              match.app_id = "^zen-beta$";
            }
            {
              default_maximize_to_edges = true;
              match.app_id = "^Thorium-browser$";
            }
            {
              default_maximize_to_edges = true;
              match.app_id = "^dev.zed.Zed$";
            }
            {
              default_maximize_to_edges = true;
              match.app_id = "^Ferdium$";
            }
            {
              default_fullscreen = true;
              match.title = "^Wuthering Waves  $";
            }
            {
              default_floating = true;
              default_maximize = false;
              default_pinned = true;
              default_position = {
                anchor = "bottom_right";
                x = 20;
                y = 20;
              };
              match.title = "^(Picture-in-Picture|Picture in picture)$";
            }
            {
              default_floating = true;
              default_size = [
                800
                600
              ];
              match.app_id = "^dev.noctalia.UmbrielSharePicker$";
            }
          ];
          workspaces = {
            back_and_forth = false;
            empty_above = true;
          };
        };
      };
    };

    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        xdg-desktop-portal-umbriel
      ];
      imports = [
        inputs.umbriel.nixosModules.default
      ];
      nixpkgs.overlays = [
        inputs.umbriel.overlays.default
        inputs.xdg-desktop-portal-umbriel.overlays.default
      ];
      programs.umbriel.enable = true;
    };
  };
  flake-file.inputs = {
    umbriel = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://github.com/noctalia-dev/umbriel?submodules=1";
    };
    xdg-desktop-portal-umbriel = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:noctalia-dev/xdg-desktop-portal-umbriel";
    };
  };
}
