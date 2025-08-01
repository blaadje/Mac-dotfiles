{ config, fontConfig }: {
  settings = {
    copy_on_select = "yes";
    hide_window_decorations = "titlebar-only";
    confirm_os_window_close = 0;
    window_padding_width = 10;
    background_opacity = 1;
    background_blur = 30;
    font_family = "${fontConfig.family}";
    font_size = "13";
    undercurl_style = "thick-dense";
    resize_debounce_time = 0;
    cursor_shape = "block";
    color0 = "#${config.colorScheme.palette.base00}";
    color1 = "#${config.colorScheme.palette.base08}";
    color2 = "#${config.colorScheme.palette.base0B}";
    color3 = "#${config.colorScheme.palette.base0A}";
    color4 = "#${config.colorScheme.palette.base0D}";
    color5 = "#${config.colorScheme.palette.base0E}";
    color6 = "#${config.colorScheme.palette.base0C}";
    color7 = "#${config.colorScheme.palette.base05}";
    color8 = "#${config.colorScheme.palette.base03}";
    color9 = "#${config.colorScheme.palette.base08}";
    color10 = "#${config.colorScheme.palette.base0B}";
    color11 = "#${config.colorScheme.palette.base0A}";
    color12 = "#${config.colorScheme.palette.base0D}";
    color13 = "#${config.colorScheme.palette.base0E}";
    color14 = "#${config.colorScheme.palette.base0C}";
    color15 = "#${config.colorScheme.palette.base07}";
    color16 = "#${config.colorScheme.palette.base09}";
    color17 = "#${config.colorScheme.palette.base0F}";
    color18 = "#${config.colorScheme.palette.base01}";
    color19 = "#${config.colorScheme.palette.base02}";
    color20 = "#${config.colorScheme.palette.base04}";
    color21 = "#${config.colorScheme.palette.base06}";

    background = "#${config.colorScheme.palette.base00}";
    foreground = "#${config.colorScheme.palette.base05}";
    selection_background = "#${config.colorScheme.palette.base05}";
    selection_foreground = "#${config.colorScheme.palette.base00}";
    url_color = "#${config.colorScheme.palette.base04}";
    cursor = "#${config.colorScheme.palette.base05}";
    active_border_color = "#${config.colorScheme.palette.base03}";
    inactive_border_color = "#${config.colorScheme.palette.base01}";
    active_tab_background = "#${config.colorScheme.palette.base00}";
    active_tab_foreground = "#${config.colorScheme.palette.base05}";
    inactive_tab_background = "#${config.colorScheme.palette.base01}";
    inactive_tab_foreground = "#${config.colorScheme.palette.base04}";
    tab_bar_background = "#${config.colorScheme.palette.base01}";
  };

  extraConfig = ''
        shell /etc/profiles/per-user/alexandre.charlot/bin/fish
        modify_font underline_thickness 200%
        modify_font underline_position 10px
        map ctrl+tab send_text normal,application \x1b[9;5u
        map ctrl+shift+tab send_text normal,application \x1b[9;6u
        map ctrl+shift+f send_text normal \x1b[91~
        shell_integration no-cursor
        # Map Command key to Meta
    map cmd+c send_text all \x03
    map ctrl+w none
    map ctrl+shift+n no_op
  '';

}
