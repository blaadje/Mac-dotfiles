{ config, pkgs, fontConfig, ... }:

{
  home.file.".config/sketchybar/sketchybarrc" = {
    text = ''
      # SketchyBar Configuration
      CONFIG_DIR="$HOME/.config/sketchybar"
      PLUGIN_DIR="$CONFIG_DIR/plugins"

      sketchybar --bar position=top height=25 color="0xff${config.colorScheme.palette.base00}"

      sketchybar --add event focus_change

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

      # Mapping explicite AeroSpace monitor -> SketchyBar display
      # Monitor 2 (Built-in Retina) avec workspaces 4,5,6 -> Display 3
      # Monitor 3 (27GN7) avec workspace 2 -> Display 2
      declare -A monitor_to_display_map
      monitor_to_display_map[1]=1  # PHL 279P1
      monitor_to_display_map[2]=3  # Built-in Retina Display  
      monitor_to_display_map[3]=2  # 27GN7
      
      for monitor_id in $(${pkgs.aerospace}/bin/aerospace list-monitors | grep -E "^[0-9]+" | cut -d' ' -f1); do
        # Détection automatique des workspaces par moniteur
        workspace_ids=$(${pkgs.aerospace}/bin/aerospace list-workspaces --monitor "$monitor_id")
        display_id=''${monitor_to_display_map[$monitor_id]}
        
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
              display="$display_id" \
              click_script="aerospace workspace $sid" \
              script="$PLUGIN_DIR/aerospace.sh $sid"
        done
      done

      # Ajouter clock et battery sur chaque moniteur avec le bon mapping
      for monitor_id in $(${pkgs.aerospace}/bin/aerospace list-monitors | grep -E "^[0-9]+" | cut -d' ' -f1); do
        display_id=''${monitor_to_display_map[$monitor_id]}
        
        sketchybar --add item clock.$monitor_id right \
          --set clock.$monitor_id \
            icon.font="${fontConfig.family}:Bold:${fontConfig.size}.0" \
            label.font="${fontConfig.family}:Heavy:${fontConfig.size}.0" \
            label.y_offset=0 \
            icon.y_offset=0 \
            update_freq=10 \
            display="$display_id" \
            script="$PLUGIN_DIR/clock.sh"

        sketchybar --add item battery.$monitor_id right \
          --set battery.$monitor_id \
            icon.font="${fontConfig.family}:Bold:${fontConfig.size}.0" \
            label.font="${fontConfig.family}:Heavy:${fontConfig.size}.0" \
            label.y_offset=3 \
            icon.y_offset=1 \
            label.align=center \
            icon.y_offset=0 \
            label.padding_right=10 \
            update_freq=60 \
            display="$display_id" \
            script="$PLUGIN_DIR/battery.sh"
      done
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
