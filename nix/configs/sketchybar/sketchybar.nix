{ config, pkgs, fontConfig, ... }:

{
  home.file.".config/sketchybar/sketchybarrc" = {
    text = ''
      # SketchyBar Configuration
      CONFIG_DIR="$HOME/.config/sketchybar"
      PLUGIN_DIR="$CONFIG_DIR/plugins"

      sketchybar --bar position=top height=25 color="0xff${config.colorScheme.palette.base00}"

      sketchybar --add event focus_change

      . "$PLUGIN_DIR/items.sh"

      sketchybar --update
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

  home.file.".config/sketchybar/plugins/items.sh" = {
    text = ''
      #!/usr/bin/env bash

      CONFIG_DIR="$HOME/.config/sketchybar"
      PLUGIN_DIR="$CONFIG_DIR/plugins"

      # Clear existing items
      sketchybar --remove '/.*/'

      sketchybar --add event wm_workspace_changed

      for sid in 1 2 3 4 5 6; do
        sketchybar --add item space.$sid left \
          --subscribe space.$sid wm_workspace_changed \
          --set space.$sid \
            label="$sid" \
            label.font="${fontConfig.family}:Heavy:${fontConfig.size}.0" \
            label.padding_left=12 \
            label.padding_right=12 \
            label.color=0xff${config.colorScheme.palette.base03} \
            background.corner_radius=3 \
            background.height=18 \
            background.color=0xff${config.colorScheme.palette.base0F} \
            background.drawing=off \
            script="$PLUGIN_DIR/wm.sh $sid"
      done

      sketchybar --add item clock right \
        --set clock \
          icon.font="${fontConfig.family}:Bold:${fontConfig.size}.0" \
          label.font="${fontConfig.family}:Heavy:${fontConfig.size}.0" \
          label.y_offset=0 \
          icon.y_offset=0 \
          update_freq=10 \
          script="$PLUGIN_DIR/clock.sh"

      sketchybar --add item battery right \
        --set battery \
          icon.font="${fontConfig.family}:Bold:${fontConfig.size}.0" \
          label.font="${fontConfig.family}:Heavy:${fontConfig.size}.0" \
          label.y_offset=3 \
          icon.y_offset=1 \
          label.align=center \
          icon.y_offset=0 \
          label.padding_right=10 \
          update_freq=60 \
          script="$PLUGIN_DIR/battery.sh"
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

  home.file.".config/sketchybar/plugins/wm.sh" = {
    text = ''
      #!/usr/bin/env bash

      if [ -n "$WM_WORKSPACE_INDEX" ]; then
        idx="$WM_WORKSPACE_INDEX"
      elif [ -n "$WM_WORKSPACE_NAME" ]; then
        idx="$((WM_WORKSPACE_NAME - 1))"
      else
        exit 0
      fi

      focused="$((idx + 1))"
      if [ "$1" = "$focused" ]; then
        sketchybar --set "$NAME" background.drawing=on label.color=0xff${config.colorScheme.palette.base00}
      else
        sketchybar --set "$NAME" background.drawing=off label.color=0xff${config.colorScheme.palette.base03}
      fi
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

  home.file.".config/sketchybar/plugins/battery.sh" = {
    text = ''
      #!/usr/bin/env bash
      PERCENTAGE="$(pmset -g batt | grep -Eo '\d+%' | cut -d% -f1)"
      CHARGING="$(pmset -g batt | grep 'AC Power')"

      if [ "$PERCENTAGE" = "" ]; then
        exit 0
      fi

      if [[ "$CHARGING" != "" ]]; then
        ICON="⚡"
      else
        if [ "$PERCENTAGE" -gt 80 ]; then
          ICON="🔋"
        elif [ "$PERCENTAGE" -gt 60 ]; then
          ICON="🔋"
        elif [ "$PERCENTAGE" -gt 40 ]; then
          ICON="🔋"
        elif [ "$PERCENTAGE" -gt 20 ]; then
          ICON="🪫"
        else
          ICON="🪫"
        fi
      fi

      sketchybar --set "$NAME" label="$ICON $PERCENTAGE%"
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

  home.file.".config/sketchybar/plugins/clock.sh" = {
    text = ''
      #!/usr/bin/env bash
      sketchybar --set "$NAME" label="$(date '+%H:%M')"
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

}
