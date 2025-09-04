{ lib, pkgs ? import <nixpkgs> { } }: {
  focus_left = "aerospace focus left";
  focus_down = "aerospace focus down";
  focus_up = "aerospace focus up";
  focus_right = "aerospace focus right";

  move_left = "aerospace move left";
  move_down = "aerospace move down";
  move_up = "aerospace move up";
  move_right = "aerospace move right";

  move_node_to_workspace_1 = "aerospace move-node-to-workspace 1";
  move_node_to_workspace_2 = "aerospace move-node-to-workspace 2";
  move_node_to_workspace_3 = "aerospace move-node-to-workspace 3";
  move_node_to_workspace_4 = "aerospace move-node-to-workspace 4";
  move_node_to_workspace_5 = "aerospace move-node-to-workspace 5";
  move_node_to_workspace_6 = "aerospace move-node-to-workspace 6";

  workspace_1 = "aerospace workspace 1";
  workspace_2 = "aerospace workspace 2";
  workspace_3 = "aerospace workspace 3";
  workspace_4 = "aerospace workspace 4";
  workspace_5 = "aerospace workspace 5";
  workspace_6 = "aerospace workspace 6";

  toggle_fullscreen = "aerospace fullscreen";

  # Tree manipulation commands
  rotate_tree = "aerospace layout h_tiles v_tiles";
  join_left = "aerospace join-with left";

  # Resize commands (smart adapts automatically to tree orientation)
  resize_decrease_width = "aerospace resize smart -50";
  resize_increase_width = "aerospace resize smart +50";
}
