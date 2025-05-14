{
  programs.cava.enable = true;
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      topBar = {
        layer = "top";
	position = "top";
	reload_style_on_change = true;

	modules-left = [
          "hyprland/workspaces"
	  "wlr/taskbar"
	  "hyprland/window"
	];

	modules-center = [
	  "cava"
	];
	
	modules-right = [
	  "mpris"
          "backlight"
	  "wireplumber"
	  "battery"
          "cpu"
	  "memory"
	  "network"
          "clock"
	];

	network = {
	  interval = 1;
          format = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
	};

	"wlr/taskbar" = {
           on-click = "activate";
	   tooltop = "{title}";
	};

        mpris = {
	  interval = 1;
	  format = "{player_icon} {title} - {artist}";
	  format-paused = "{status_icon} {title} - {artist}";
	  player-icons = {
            default = "▶";
            mpv = "🎵";
	  };
	  status-icons = {
	    paused = "⏸";
	  };
	};

	"hyprland/workspaces" = {
          persistent-workspaces = {
            "*" = [ 1 2 3 4 5 ];
          };
        };

	cava = {
          framerate = 30;
	  sensitivity = 2;
          bars = 14;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 1500;
	  hide_on_silence = true;
	  bar_delimiter = 0;
          method = "pipewire";
          stereo = false;
          reverse = false;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          actions = {
            on-click-right = "mode";
          };
        };
      };
    };
  };
}
