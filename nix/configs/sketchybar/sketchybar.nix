{ config, pkgs, fontConfig, ... }:

{
  home.file.".config/sketchybar/sketchybarrc" = {
    text = ''
      # SketchyBar Configuration
      CONFIG_DIR="$HOME/.config/sketchybar"
      PLUGIN_DIR="$CONFIG_DIR/plugins"

      sketchybar --bar position=top height=25 color="0xff${config.colorScheme.palette.base00}" display=all

      sketchybar --add event focus_change
      sketchybar --subscribe monitor_watcher focus_change

      sketchybar --add item monitor_watcher hidden \
        --set monitor_watcher \
          script="$PLUGIN_DIR/monitor_watch.sh" \
          updates=on \
          update_freq=1 \
          drawing=off

      source "$PLUGIN_DIR/items.sh"

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

      sketchybar --add event aerospace_workspace_change

      for monitor_id in $(${pkgs.aerospace}/bin/aerospace list-monitors | grep -E "^[0-9]+" | cut -d' ' -f1); do
        workspace_ids=$(${pkgs.aerospace}/bin/aerospace list-workspaces --monitor "$monitor_id")
        
        for sid in $workspace_ids; do
          sketchybar --add item space.$sid left \
            --subscribe space.$sid aerospace_workspace_change \
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
              display="$monitor_id" \
              click_script="aerospace workspace $sid" \
              script="$PLUGIN_DIR/aerospace.sh $sid"
        done
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

  home.file.".config/sketchybar/plugins/aerospace.sh" = {
    text = ''
      #!/usr/bin/env bash

      if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
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

      sketchybar --set battery label="$ICON $PERCENTAGE%"
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

  home.file.".config/sketchybar/plugins/clock.sh" = {
    text = ''
      #!/usr/bin/env bash
      sketchybar --set clock label="$(date '+%H:%M')"
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };

  home.file.".config/sketchybar/plugins/monitor_watch.sh" = {
    text = ''
      #!/usr/bin/env bash

      MONITOR_LIST="$(${pkgs.aerospace}/bin/aerospace list-monitors | grep -E '^[0-9]+' | cut -d' ' -f1 | sort | tr '\n' ' ')"
      CHECKSUM=$(echo "$MONITOR_LIST" | shasum)

      STATE_FILE="/tmp/sketchybar-monitors-checksum"
      OLD_CHECKSUM=$(cat "$STATE_FILE" 2>/dev/null)

      if [ "$CHECKSUM" != "$OLD_CHECKSUM" ]; then
        echo "$CHECKSUM" > "$STATE_FILE"
        "$HOME/.config/sketchybar/plugins/items.sh"
      fi
    '';
    executable = true;
    onChange = "${pkgs.sketchybar}/bin/sketchybar --reload";
  };
}
