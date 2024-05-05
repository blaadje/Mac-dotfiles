{ config }: {
  settings = {
    env = { "TERM" = "xterm-256color"; };

    window = {
      padding.x = 15;
      padding.y = 15;
      decorations = "Buttonless";
    };

    font = {
      size = 15.0;
      normal = {
        family = "MesloLGL Nerd Font";
        style = "Regular";
      };
    };

    colors = {
      # Default colors
      primary = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
      };

      # Colors the cursor will use if `custom_cursor_colors` is true
      cursor = {
        text = "#${config.colorScheme.palette.base00}";
        cursor = "#${config.colorScheme.palette.base05}";
      };

      # Normal colors
      normal = {
        black = "#${config.colorScheme.palette.base00}";
        red = "#${config.colorScheme.palette.base08}";
        green = "#${config.colorScheme.palette.base0B}";
        yellow = "#${config.colorScheme.palette.base0A}";
        blue = "#${config.colorScheme.palette.base0D}";
        magenta = "#${config.colorScheme.palette.base0E}";
        cyan = "#${config.colorScheme.palette.base0C}";
        white = "#${config.colorScheme.palette.base05}";
      };

      # Bright colors
      bright = {
        black = "#${config.colorScheme.palette.base03}";
        red = "#${config.colorScheme.palette.base09}";
        green = "#${config.colorScheme.palette.base01}";
        yellow = "#${config.colorScheme.palette.base02}";
        blue = "#${config.colorScheme.palette.base04}";
        magenta = "#${config.colorScheme.palette.base06}";
        cyan = "#${config.colorScheme.palette.base0F}";
        white = "#${config.colorScheme.palette.base07}";
      };
    };

    shell = {
      program = "/etc/profiles/per-user/${builtins.getEnv ("USER")}/bin/fish";
    };
  };
}
