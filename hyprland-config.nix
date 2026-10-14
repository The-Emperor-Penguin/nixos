{ config, pkgs, lib, ... }:

{
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
            "XF86AudioRaiseVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioMicMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%+\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%-\")")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioNext"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"playerctl next\")")
            {
              locked = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioPause"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"playerctl play-pause\")")
            {
              locked = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioPlay"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"playerctl play-pause\")")
            {
              locked = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"playerctl previous\")")
            {
              locked = true;
            }
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
        {
          _args = [
            "SUPER + mouse:272"
            (lib.generators.mkLuaInline "hl.dsp.window.drag()")
            {
              mouse = true;
              drag = true;
            }
          ];
        }
      ] ++ (
        # Programmatically generate workspaces 1-10
        builtins.concatLists (builtins.genList (
          i:
          let
            ws = i + 1;
            key = if ws == 10 then "0" else builtins.toString ws;
          in [
            # Focus workspace
            {
              _args = [
                "SUPER + ${key}"
                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = ${builtins.toString ws} })")
              ];
            }
            # Move window to workspace
            {
              _args = [
                "SUPER + SHIFT + ${key}"
                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = ${builtins.toString ws} })")
              ];
            }
          ]
        ) 10)
      );

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
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n hl.exec_cmd(\"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP PATH\")\nend")
          ];
        }
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n hl.exec_cmd(\"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP PATH\")\nend")
          ];
        }
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n hl.exec_cmd(\"systemctl --user start hyprland-session.target\")\nend")
          ];
        }
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n hl.exec_cmd(\"systemctl --user start xdg-desktop-portal-hyprland.service xdg-desktop-portal-gtk.service xdg-desktop-portal.service\")\nend")
          ];
        }
      ];
    };
  };    
}
