let folderPath = builtins.toString ./.;
in {
  config = ''
    CURRENT_DIR="${folderPath}"

    source "$CURRENT_DIR/colors.sh"
    source "$CURRENT_DIR/icons.sh"

    ITEM_DIR="$CURRENT_DIR/items"     # Directory where the items are configured
    PLUGIN_DIR="$CURRENT_DIR/plugins" # Directory where all the plugin scripts are stored

    FONT="MesloLGL Nerd Font"

    ##### Bar Appearance #####
    # Configuring the general appearance of the bar, these are only some of the
    # options available. For all options see:
    # https://felixkratz.github.io/sketchy_bottombar/config/bar
    # If you are looking for other colors, see the color picker:
    # https://felixkratz.github.io/sketchy_bottombar/config/tricks#color-picker
    sketchybar --bar color=0x00000000 \
         height=48        \
         margin=15         \
         y_offset=1 \
                        padding_left=0   \
         padding_right=8 \
         position=bottom 

    ##### Changing Defaults #####
    # We now change some default values that are applied to all further items
    # For a full list of all available item properties see:
    # https://felixkratz.github.io/sketchy_bottombar/config/items

    sketchybar --default padding_left=0                                    \
       padding_right=0                                   \
                                                         \
       background.border_width=2                         \
       background.height=36                              \
       background.corner_radius=12                       \
                                                         \
       icon.color=$COLOR_TEN                          \
       icon.highlight_color=$COLOR_BACKGROUND            \
       icon.padding_left=6                               \
       icon.padding_right=2                              \
       icon.font="MesloLGL Nerd Font:Regular:16.0"  \
                                                         \
       label.color=$COLOR_TEN                         \
       label.highlight_color=$COLOR_BACKGROUND           \
       label.padding_left=4                              \
       label.padding_right=6                             \
       label.font="MesloLGL Nerd Font:Regular:12.0"

        ##### Adding Menu #####
    source "$ITEM_DIR/yabai.sh"
    source "$ITEM_DIR/spaces.sh"
    source "$ITEM_DIR/system.sh"
    source "$ITEM_DIR/dock.sh"


    sketchybar --update
  '';
}
