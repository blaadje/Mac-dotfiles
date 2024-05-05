{ config }: {
  position = "top";
  height = 20;
  spacing_left = 25;
  spacing_right = 15;
  text_font = "FiraCode Nerd Font:Medium:16.0";
  icon_font = "FiraCode Nerd Font:Medium:16.0";
  background_color = "0xff${config.colorScheme.palette.base00}";
  foreground_color = "0xff${config.colorScheme.palette.base05}";
  space_icon_color = "0xffc86663";
  power_icon_color = "0xffcd950c";
  battery_icon_color = "0xffd75f5f";
  dnd_icon_color = "0xffa8a8a8";
  clock_icon_color = "0xffa8a8a8";
  space_icon = "•";
  space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
  power_icon_strip = "🔋 🪫";
  display_separator = "on";
  display_separator_icon = "";
  # space_icon = "";
  clock_icon = "🕕";
  dnd_icon = "🔋";
  battery_icon = "🔋";
  title = "off";
  clock_format = ''"%R - %A %d %b"'';
}
