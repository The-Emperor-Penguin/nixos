{

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          "layer" = "top";
          "position" = "top";
          "height" = 30;
          "width" = 1280;
          "spacing" = 4;
          
          "modules-left" = [
              "sway/workspaces"
              "sway/mode"
              "sway/scratchpad"
              "custom/media"
          ];
          "modules-center" = [
              "sway/window"
          ];
          "modules-right" = [
              "mpd"
              "pulseaudio"
              "network"
              "cpu"
              "memory"
              "clock"
              "tray"
              "custom/power"
          ];
          "mpd" = {
              "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime =%M =%S}/{totalTime =%M =%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
              "format-disconnected" = "Disconnected ";
              "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
              "unknown-tag" = "N/A";
              "interval" = 5;
              "consume-icons" = {
                  "on" = " ";
              };
              "random-icons" = {
                  "off" = "<span color=\"#f53c3c\"></span> ";
                  "on" = " ";
              };
              "repeat-icons" = {
                  "on" = " ";
              };
              "single-icons" = {
                  "on" = "1 ";
              };
              "state-icons" = {
                  "paused" = "";
                  "playing" = "";
              };
              "tooltip-format" = "MPD (connected)";
              "tooltip-format-disconnected" = "MPD (disconnected)";
          };
          "tray" = {
              "spacing" = 10;

          };
          "clock" = {
            "format" = "{:%I:%M:%S %p}";
            "tooltip-format" = "<big>{ =%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            "format-alt" = "{ =%Y-%m-%d}";
          };
          "cpu" = {
              "format" = "{usage}% ";
              "tooltip" = false;
          };
          "memory" = {
              "format" = "{}% ";
          };
          "network" = {
              "format-wifi" = "{essid} ({signalStrength}%) ";
              "format-ethernet" = "{ipaddr}/{cidr} ";
              "tooltip-format" = "{ifname} via {gwaddr} 󰊗";
              "format-linked" = "{ifname} (No IP) 󰊗";
              "format-disconnected" = "Disconnected ⚠";
              "format-alt" = "{ifname} = {ipaddr}/{cidr}";
          };
          "pulseaudio" = {
              "format" = "{volume}% {icon} {format_source}";
              "format-bluetooth" = "{volume}% {icon} {format_source}";
              "format-bluetooth-muted" = "󰅶 {icon} {format_source}";
              "format-muted" = "󰅶 {format_source}";
              "format-source" = "{volume}% ";
              "format-source-muted" = "";
              "format-icons" = {
                  "headphone" = "";
                  "hands-free" = "󰂑";
                  "headset" = "󰂑";
                  "phone" = "";
                  "portable" = "";
                  "car" = "";
                  "default" = ["" "" ""];
              };
              "on-click" = "pavucontrol";
          };
          "custom/media" = {
              "format" = "{icon} {text}";
              "return-type" = "json";
              "max-length" = 40;
              "format-icons" = {
                  "spotify" = "";
                  "default" = "🎜";
              };
              "escape" = true;
              "exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
              
          };
          "custom/power" = {
            "format"  = "⏻ ";
            "tooltip" = false;
          };
        };
      };
    };
}
