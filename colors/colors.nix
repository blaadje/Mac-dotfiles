{ lib, ... }:

with lib;

{
  options.colors =
    let
      mkColorOption = name: {
        inherit name;
        value = mkOption {
          type = types.strMatching "#[a-fA-F0-9]{6}";
          description = "Color ${name}.";
        };
      };
    in
      listToAttrs (map mkColorOption [
        "background" "foreground" "cursor" "color0" "color1" "color2"
        "color3" "color4" "color5" "color6" "color7" "color8" "color9"
        "color10" "color11" "color12" "color13" "color14" "color15"
      ]);
}