{ config }: {
  width = "6.0";
  active_color =
    "gradient(top_left=0xff${config.colorScheme.colors.base08},bottom_right=0xff${config.colorScheme.colors.base05})";
  inactive_color = "0x00000000";
  hidpi = "on";
  ax_focus = "off";
}
