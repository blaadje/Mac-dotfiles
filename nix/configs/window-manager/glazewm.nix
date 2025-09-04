{ pkgs, lib, ... }:

let
  wmKeybinds = import ./keybinds/window-manager-keybinds.nix {
    inherit lib pkgs;
    modifiers = {
      alt = "alt";
      shift = "shift";
      super = "win";
      control = "ctrl";
    };
  };

  commandMap = import ./keybinds/glazewm-keybinds.nix { inherit lib pkgs; };

  convertKeybinds = keybinds:
    lib.mapAttrsToList (binding: command:
      let glazeCommand = commandMap.${command} or command;
      in {
        commands = [ glazeCommand ];
        bindings = [ binding ];
      }) keybinds;

  glazeWMConfig = {
    general = {
      startup_commands = [ "shell-exec zebar" ];
      shutdown_commands = [ "shell-exec taskkill /IM zebar.exe /F" ];
      config_reload_commands = [ ];
      focus_follows_cursor = true;
      toggle_workspace_on_refocus = false;
      cursor_jump = {
        enabled = true;
        trigger = "monitor_focus";
      };
      hide_method = "cloak";
      show_all_in_taskbar = false;
    };

    gaps = {
      scale_with_dpi = true;
      inner_gap = "5px";
      outer_gap = {
        top = "50px";
        right = "10px";
        bottom = "10px";
        left = "10px";
      };
    };

    window_effects = {
      focused_window = {
        border = {
          enabled = true;
          color = "#8dbcff";
        };
        hide_title_bar = { enabled = false; };
        corner_style = {
          enabled = true;
          style = "square";
        };
        transparency = {
          enabled = false;
          opacity = "95%";
        };
      };
      other_windows = {
        border = {
          enabled = true;
          color = "#a1a1a1";
        };
        hide_title_bar = { enabled = false; };
        corner_style = {
          enabled = true;
          style = "square";
        };
        transparency = {
          enabled = false;
          opacity = "0%";
        };
      };
    };

    window_behavior = {
      initial_state = "tiling";
      state_defaults = {
        floating = {
          centered = true;
          shown_on_top = true;
        };
        fullscreen = {
          maximized = false;
          shown_on_top = true;
        };
      };
    };

    workspaces = [
      {
        name = "1";
        keep_alive = true;
      }
      {
        name = "2";
        keep_alive = true;
      }
      {
        name = "3";
        keep_alive = true;
      }
      {
        name = "4";
        keep_alive = true;
      }
      {
        name = "5";
        keep_alive = true;
        bind_to_monitor = 1;
      }
      {
        name = "6";
        keep_alive = true;
      }
    ];

    window_rules = [
      {
        commands = [ "move --workspace 1" ];
        match =
          [{ window_title = { regex = "Call of Duty 2x Multiplayer"; }; }];
      }
      {
        commands = [ "ignore" ];
        match = [
          { window_process = { equals = "zebar"; }; }
          {
            window_title = { regex = "[Pp]icture.in.[Pp]icture"; };
            window_class = { regex = "Chrome_WidgetWin_1|MozillaDialogClass"; };
          }
          {
            window_process = { equals = "PowerToys"; };
            window_class = {
              regex = "HwndWrapper\\[PowerToys\\.PowerAccent.*?\\]";
            };
          }
          {
            window_process = { equals = "PowerToys"; };
            window_title = { regex = ".*? - Peek"; };
          }
          {
            window_process = { equals = "Lively"; };
            window_class = { regex = "HwndWrapper"; };
          }
        ];
      }
    ];

    keybindings = convertKeybinds wmKeybinds;
  };

in {
  # Configuration GlazeWM pour Windows via WSL
  home.file."configs/glazewm/config.yaml" = {
    source = pkgs.runCommand "glazewm-config.yaml" {
      buildInputs = [ pkgs.yj ];
      json = builtins.toJSON glazeWMConfig;
      passAsFile = [ "json" ];
    } ''
      yj -jy < "$jsonPath" > $out
    '';
  };
}
