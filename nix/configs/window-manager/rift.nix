{ config, pkgs, lib, ... }:

let
  riftConfig = ''
    [settings]
    animate = false
    animation_duration = 0.3
    animation_fps = 100.0
    animation_easing = "ease_in_out"
    focus_follows_mouse = true
    mouse_follows_focus = true
    mouse_hides_on_focus = false
    hot_reload = false
    default_disable = false
    run_on_start = [
      "${pkgs.rift}/bin/rift-cli subscribe cli --event workspace_changed --command sh --args -c --args '${pkgs.sketchybar}/bin/sketchybar --trigger wm_workspace_changed WM_WORKSPACE_NAME=\"$RIFT_WORKSPACE_NAME\"'",
    ]

    [settings.layout]
    mode = "bsp"

    [settings.layout.gaps.outer]
    top = 34
    left = 10
    bottom = 10
    right = 10

    [settings.layout.gaps.inner]
    horizontal = 10
    vertical = 10

    [settings.layout.gaps.per_display."37D8832A-2D66-02CA-B9F7-8F30A301B230".outer]
    top = 10

    [virtual_workspaces]
    enabled = true
    default_workspace_count = 6
    auto_assign_windows = true
    preserve_focus_per_workspace = true
    workspace_auto_back_and_forth = false
    reapply_app_rules_on_title_change = false

    workspace_names = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6"
    ]

    app_rules = [
      { app_name = "Code", workspace = 1 },
      { title_regex = "vimwindow", workspace = 1 },
      { title_substring = "Todolist", floating = true },
      { title_regex = "OBS.*", floating = true },
      { app_name = "System Settings", floating = true },
      { app_name = "System Preferences", floating = true }
    ]

    [keys]
  '';
in { home.file.".config/rift/config.toml" = { text = riftConfig; }; }
