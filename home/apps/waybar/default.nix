{
  programs.cava.enable = true;
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ./style.css;
    settings = {
      topBar = {
        layer = "top";
	position = "top";
	reload_style_on_change = true;

	modules-left = [
	  "group/groupleftbg"
	  "custom/revborder-left"
	  "hyprland/window"
	];

	modules-center = [
	  "custom/revborder-mid-left"
          "group/groupclock"
	  "custom/revborder-mid-right"
	];
	
	modules-right = [
	  "mpris"
	  "custom/revborder-right"
	  "group/grouprightbg"
	];
          
	"group/groupclock" = {
           orientation = "horizontal";
	   modules = [
             "clock#date"
             "clock#clock"
	   ];
	};

	"group/groupleft" = {
           orientation = "horizontal";
	   modules = [
             "hyprland/workspaces"
	     "wlr/taskbar"
	   ];
	};

	"group/groupleftbg" = {
           orientation = "horizontal";
	   modules = [
	     "group/groupleft"
	   ];
	};
	
	"group/groupright" = {
           orientation = "horizontal";
	   modules = [
             "cpu"
	     "memory"
	     "network"
             "backlight"
	     "wireplumber"
	     "battery"
	   ];
	};
        
	"group/grouprightbg" = {
           orientation = "horizontal";
	   modules = [
	     "group/groupright"
	   ];
	};

	"custom/revborder-mid-left" = {
           format = " ";
	};

	"custom/revborder-mid-right" = {
           format = " ";
	};

	"custom/revborder-left" = {
           format = " ";
	};

	"custom/revborder-right" = {
           format = " ";
	};

	cpu = {
          interval = 1;
	  format = "   {usage}%";
	};

	memory = {
          interval = 1;
	  format = "   {percentage}%";
	};

        battery = {
          interval = 1;
	  tooltip-format = "{time}";
	  format = "{icon}   {capacity}%";
	  format-icons = ["" "" "" "" ""];
	  format-plugged = "   {capacity}%";
	};

	backlight = {
          format-icons = [ "󰃞" "󰃟" "󰃝" "󰃠" ];
	  format = "{icon}   {percent}%";
	};

	wireplumber = {
          format-icons = [ "" "" "" ];
	  format = "{icon}   {volume}%";
          format-muted = "    {volume}%";
          on-click = "pavucontrol";
	};

	"clock#date" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	  format = "{:%A, %d %b %Y}";
	  timezone = "Asia/Jakarta";
	  interval = 1;
	};

	"clock#clock" = {
          tooltip-format = "{:%T}";
	  format = "{:%T}";
	  timezone = "Asia/Jakarta";
	  interval = 1;
	};

	network = {
	  interval = 1;
          format = "  {bandwidthUpBytes}    {bandwidthDownBytes}";
	  tooltip-format = "{ipaddr}";
	};

	"wlr/taskbar" = {
           on-click = "activate";
	   tooltop = "{title}";
	};

        mpris = {
	  interval = 1;
	  format = "{title} - {artist} {player_icon}";
	  format-paused = "{title} - {artist} {status_icon}";
	  title-len = 30;
	  artist-len = 20;
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
