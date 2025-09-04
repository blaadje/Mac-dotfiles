{ lib, pkgs ? import <nixpkgs> { } }: {
  focus_left = "yabai -m window --focus west";
  focus_down = "yabai -m window --focus south";
  focus_up = "yabai -m window --focus north";
  focus_right = "yabai -m window --focus east";

  move_left = "yabai -m window --warp west";
  move_down = "yabai -m window --warp south";
  move_up = "yabai -m window --warp north";
  move_right = "yabai -m window --warp east";

  move_node_to_workspace_1 = "yabai -m window --space 1";
  move_node_to_workspace_2 = "yabai -m window --space 2";
  move_node_to_workspace_3 = "yabai -m window --space 3";
  move_node_to_workspace_4 = "yabai -m window --space 4";
  move_node_to_workspace_5 = "yabai -m window --space 5";
  move_node_to_workspace_6 = "yabai -m window --space 6";

  workspace_1 = "yabai -m space --focus 1";
  workspace_2 = "yabai -m space --focus 2";
  workspace_3 = "yabai -m space --focus 3";
  workspace_4 = "yabai -m space --focus 4";
  workspace_5 = "yabai -m space --focus 5";
  workspace_6 = "yabai -m space --focus 6";

  toggle_fullscreen = "yabai -m window --toggle zoom-fullscreen";
}
