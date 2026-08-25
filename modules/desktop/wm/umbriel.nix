{
  inputs,
  ...
}:
{
  dotnix.umbriel = {
    homeManager = {
      imports = [
        inputs.umbriel.homeModules.default
      ];

      nixpkgs.overlays = [
        inputs.umbriel.overlays.default
        inputs.xdg-desktop-portal-umbriel.overlays.default
      ];

      programs.umbriel = {
        enable = true;
        settings = {
          appearance = {
            animation_ms = 250;
            blur = {
              enabled = true;
              noise = 0.02;
              optimized = true;
              passes = 2;
              radius = 3;
              saturation = 1.0;
            };
            border_width = 1;
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
              "niriusd"
              "valent --gapplication-service"
            ];
            focus_on_activate = true;
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
            "Mod+Q" = "window-close";
            "Mod+Return" = "spawn:kitty";
            "Mod+Space" = "spawn:vicinae toggle";
          };
          layout = {
            gap = 8;
            mode = "scrolling";
            scrolling = {
              center_underfull_strip = true;
              default_width_fraction = 0.5;
            };
            width_presets = [
              0.333
              0.5
              0.667
              1.0
            ];
          };
          workspaces = {
            back_and_forth = false;
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
