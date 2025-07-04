{ config, pkgs, lib, ... }:

{
  home.file.".config/sketchybar/sketchybarrc" = {
    text = ''
      # SketchyBar Configuration
      CONFIG_DIR="$HOME/.config/sketchybar"
      PLUGIN_DIR="$CONFIG_DIR/plugins"

      sketchybar --bar position=top height=25 color="0xff${config.colorScheme.palette.base00}"

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

      workspace_ids=$(${pkgs.aerospace}/bin/aerospace list-workspaces --monitor focused | grep -Eo '^[0-9]+')

      # Détermine le plus grand numéro
      max_sid=$(echo "$workspace_ids" | sort -nr | head -n1)

      # Si vide, fallback à 6 (ou autre valeur par défaut)
      if [ -z "$max_sid" ]; then
        max_sid=6
      fi

      for sid in $(seq 1 "$max_sid"); do
        sketchybar --add item space.$sid left \
          --subscribe space.$sid aerospace_workspace_change \
          --set space.$sid \
            label="$sid" \
            label.font="SF Pro:Bold:13.0" \
            label.padding_left=12 \
            label.padding_right=12 \
            label.color = 0xff${config.colorScheme.palette.base03} \
            background.corner_radius=3 \
            background.height=18 \
            background.color=0xff${config.colorScheme.palette.base0F} \
            background.drawing=off \
            click_script="aerospace workspace $sid" \
            script="$PLUGIN_DIR/aerospace.sh $sid"
      done

      sketchybar --add item clock right \
        --set clock \
          icon.font="SF Pro:Bold:14.0" \
          label.font="SF Pro:Heavy:14.0" \
          label.y_offset=0 \
          icon.y_offset=0 \
          update_freq=10 \
          script="$PLUGIN_DIR/clock.sh"

      sketchybar --add item battery right \
        --set battery \
          icon.font="SF Pro:Bold:14.0" \
          label.font="SF Pro:Bold:14.0" \
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
        sketchybar --set "$NAME" background.drawing=on
      else
        sketchybar --set "$NAME" background.drawing=off
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
}
