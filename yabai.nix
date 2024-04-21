{ config }: {
  layout = "bsp";
  window_border = "on";
  window_border_width = 3;
  active_window_border_color = "0xFF${config.colorScheme.colors.base05}";
  normal_window_border_color = "0xFF${config.colorScheme.colors.base00}";
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
}
