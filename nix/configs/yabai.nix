{ config }: {
  enableScriptingAddition = true;
  config = {
    layout = "bsp";
    window_border = "on";
    window_border_width = 3;
    active_window_border_color = "0xFF${config.colorScheme.palette.base05}";
    normal_window_border_color = "0xFF${config.colorScheme.palette.base00}";
    window_placement = "second_child";
    bottom_padding = 10;
    top_padding = 10;
    left_padding = 10;
    right_padding = 10;
    window_gap = 10;
    auto_balance = "on";
    split_ratio = "0";
    mouse_modifier = "fn";
    focus_follows_mouse = "autoraise";
    window_topmost = "on";
    window_shadow = "float";
    window_opacity = "off";
    active_window_opacity = "1.0";
    normal_window_opacity = "0.9";
  };
  extraConfig = ''
    yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

    SPACEBAR_HEIGHT=$(spacebar -m config height)
    yabai -m config external_bar main:$SPACEBAR_HEIGHT:0
    # rules
    yabai -m rule --add app="^System Preferences$" sticky=on
    yabai -m rule --add title="^Todolist$" sticky=on
    yabai -m rule --add title="OBS.*" sticky=on
    yabai -m rule --add app="^Code$" space=2
    yabai -m rule --add title="vimwindow" space=2
    echo "configuration loaded"
  '';

}
