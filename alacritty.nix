{ config }: {
  env = { "TERM" = "xterm-256color"; };

  window = {
    padding.x = 15;
    padding.y = 15;
    decorations = "buttonless";
  };

  font = {
    size = 16.0;
    # use_thin_strokes = true;
    normal = { family = "Menlo"; };
  };

  colors = {
    # Default colors
    primary = {
      background = "#${config.colorScheme.colors.base00}";
      foreground = "#${config.colorScheme.colors.base05}";
    };

    # Colors the cursor will use if `custom_cursor_colors` is true
    cursor = {
      text = "#${config.colorScheme.colors.base00}";
      cursor = "#${config.colorScheme.colors.base05}";
    };

    # Normal colors
    normal = {
      black = "#${config.colorScheme.colors.base00}";
      red = "#${config.colorScheme.colors.base08}";
      green = "#${config.colorScheme.colors.base0B}";
      yellow = "#${config.colorScheme.colors.base0A}";
      blue = "#${config.colorScheme.colors.base0D}";
      magenta = "#${config.colorScheme.colors.base0E}";
      cyan = "#${config.colorScheme.colors.base0C}";
      white = "#${config.colorScheme.colors.base05}";
    };

    # Bright colors
    bright = {
      black = "#${config.colorScheme.colors.base03}";
      red = "#${config.colorScheme.colors.base09}";
      green = "#${config.colorScheme.colors.base01}";
      yellow = "#${config.colorScheme.colors.base02}";
      blue = "#${config.colorScheme.colors.base04}";
      magenta = "#${config.colorScheme.colors.base06}";
      cyan = "#${config.colorScheme.colors.base0F}";
      white = "#${config.colorScheme.colors.base07}";
    };
  };

  shell = {
    program = "/etc/profiles/per-user/${builtins.getEnv ("USER")}/bin/fish";
  };
}
