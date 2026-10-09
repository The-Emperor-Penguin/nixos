{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    chafa
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      mod = {
        _var = "SUPER";
      };

      config = {
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
        };

        decoration = {
          rounding = 10;
        };
      };

      bind = [
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + C\"")
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
            { locked = true; }
          ];
        }
        {
          _args = [
            "SUPER + Q"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"kitty\")")
          ];
        }
        {
          _args = [
            "SUPER + R"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"rofi -show drun\")")
          ];
        }
        {
          _args = [
            "ALT + R"
            (lib.generators.mkLuaInline "hl.dsp.submap(\"resize\")")
          ];
        }
      ];

      define_submap = {
        _args = [
          "resize"
          (lib.generators.mkLuaInline "function()\n  hl.bind(\"right\", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })\n  hl.bind(\"left\", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })\n  hl.bind(\"escape\", hl.dsp.submap(\"reset\"))\nend")
        ];
      };
  
      on = [
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"waybar\")\nend")
          ];
        }
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n hl.exec_cmd(\"flatpak run com.github.zocker_160.SyncThingy\")\nend")
          ];
        }
      ];
    };
  };

  services = {
    hyprpolkitagent.enable = true;

    hyprpaper = {
     enable = true;
     settings = {
       splash = false;
       wallpaper = [
         {
           path = "/share/wallpapers/buttons.png";
         }
       ];
      };
    };
  };

  programs = {

    rofi = {
      enable = true;
      plugins = [ pkgs.rofi-calc ];
    };

    waybar = {
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
              "idle_inhibitor"
              "pulseaudio"
              "network"
              "power-profiles-daemon"
              "cpu"
              "memory"
              "temperature"
              "backlight"
              "keyboard-state"
              "sway/language"
              "battery"
              "battery#bat2"
              "clock"
              "tray"
              "custom/power"
          ];
          "niri/workspaces" = {
              "format" = "{icon} {windows}";
              "format-window-separator" = " ";
              "window-rewrite-default" = "";
              "window-rewrite" = {
                  "app_id<firefox>" = "";
                  "app_id<dolphin>" = "";
                  "app_id<org.gnome.Nautilus>" = "";
                  "app_id<thunar>" = "";
                  "app_id<foot>" = "";
              };
              "format-icons" = {
                  "1" = "1";
                  "2" = "2";
                  "3" = "3";
                  "4" = "4";
                  "5" = "5";
                  "active" = "";
                  "default" = "";
              };
          };
          "keyboard-state" = {
              "numlock" = true;
              "capslock" = true;
              "format" = "{name} {icon}";
              "format-icons" = {
                  "locked" = "";
                  "unlocked" = "";
              };
          };
          "sway/mode" = {
              "format" = "<span style=\"italic\">{}</span>";
          };
          "sway/scratchpad" = {
              "format" = "{icon} {count}";
              "show-empty" = false;
              "format-icons" = ["" ""];
              "tooltip" = true;
              "tooltip-format" = "{app} = {title}";
          };
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
          "idle_inhibitor" = {
              "format" = "{icon}";
              "format-icons" = {
                  "activated" = "";
                  "deactivated" = "";
              };
          };
          "tray" = {
              "spacing" = 10;

          };
          "clock" = {
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
          "temperature" = {
              "critical-threshold" = 80;
              "format" = "{temperatureC}°C {icon}";
              "format-icons" = ["󰉬" "" "󰉪"];
          };
          "backlight" = {
              
              "format" = "{percent}% {icon}";
              "format-icons" = ["" "" "" "" "" "" "" "" ""];
              "min-brightness" = 1;
          };
          "battery" = {
              "states" = {
                  "warning" = 30;
                  "critical" = 15;
              };
              "format" = "{capacity}% {icon}";
              "format-full" = "{capacity}% {icon}";
              "format-charging" = "{capacity}% 󰃨";
              "format-plugged" = "{capacity}% ";
              "format-alt" = "{time} {icon}";
              
              
              "format-icons" = ["" "" "" "" ""];
          };
          "battery#bat2" = {
              "bat" = "BAT2";
          };
          "power-profiles-daemon" = {
            "format" = "{icon}";
            "tooltip-format" = "Power profile = {profile}\nCPU driver = {cpu_driver}\nPlatform driver = {platform_driver}";
            "tooltip" = true;
            "format-icons" = {
              "default" = "";
              "performance" = "";
              "balanced" = "";
              "power-saver" = "";
            };
          };
          "network" = {
              "format-wifi" = "{essid} ({signalStrength}%) ";
              "format-ethernet" = "{ipaddr}/{cidr} 󰊗";
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
            "menu" = "on-click";
            "menu-file" = "$HOME/.config/waybar/power_menu.xml";
            "menu-actions" = {
              "shutdown" = "shutdown";
              "reboot" = "reboot";
              "suspend" = "systemctl suspend";
              "hibernate" = "systemctl hibernate";
            };
          };
        };
      };
    };

    bash = {
      enable = true;
      initExtra = ''
        chafa -s 20 ~/.penguin_term.png
        cal
        '';
    };

    vscode = {
      enable = true;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = lib.mkForce (with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          ms-python.python
          rust-lang.rust-analyzer
          golang.go
          mkhl.direnv
          bbenoist.nix
        ]);
        userSettings = {
          "rust-analyzer.server.path" = "rust-analyzer";
        };
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    kitty = {
      enable = true;
      enableGitIntegration = true;
      settings = {
        "remember_window_size" = "no";
      };
    };
  };
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "sky";
    vscode = {
      profiles."default" = {
        enable = true;
      };
    };
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}
