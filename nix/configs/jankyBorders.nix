{ config }: {
  width = "6.0";
  active_color = ''
    gradient(top_left=0xff${config.colorScheme.palette.base08},bottom_right=0xff${config.colorScheme.palette.base0E})
  '';
  # inactive_color = "0x00000000";
  # active_color = "0xff${config.colorScheme.palette.base0E}";
  inactive_color = "0xff${config.colorScheme.palette.base01}";
  hidpi = "on";
  ax_focus = "off";
}
