{ config }: {
  style = "round";
  width = "7.0";
  active_color = ''
    gradient(top_left=0xff${config.colorScheme.palette.base08},bottom_right=0xff${config.colorScheme.palette.base0E})
  '';
  # inactive_color = "0x00000000";
  # active_color = "0xff${config.colorScheme.palette.base0E}";
  inactive_color = "0xff${config.colorScheme.palette.base01}";
  order = "above";
  hidpi = "on";
  ax_focus = "off";
}
