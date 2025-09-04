{ lib, pkgs ? import <nixpkgs> { } }: {
  focus_left = "focus --direction left";
  focus_down = "focus --direction down";
  focus_up = "focus --direction up";
  focus_right = "focus --direction right";

  move_left = "move --direction left";
  move_down = "move --direction down";
  move_up = "move --direction up";
  move_right = "move --direction right";

  move_node_to_workspace_1 = "move --workspace 1";
  move_node_to_workspace_2 = "move --workspace 2";
  move_node_to_workspace_3 = "move --workspace 3";
  move_node_to_workspace_4 = "move --workspace 4";
  move_node_to_workspace_5 = "move --workspace 5";
  move_node_to_workspace_6 = "move --workspace 6";

  workspace_1 = "focus --workspace 1";
  workspace_2 = "focus --workspace 2";
  workspace_3 = "focus --workspace 3";
  workspace_4 = "focus --workspace 4";
  workspace_5 = "focus --workspace 5";
  workspace_6 = "focus --workspace 6";

  toggle_fullscreen = "toggle-fullscreen";
  toggle_floating = "toggle-floating --centered";
  close_window = "close";
  open_terminal = "shell-exec C:\\Windows\\System32\\wslg.exe ~ /bin/bash -c \"export DISPLAY=172.26.96.1:0.0 && kitty\"";

  # Tree manipulation commands
  rotate_tree = "toggle-tiling-direction";
  join_left = "move --direction left";

  # Resize commands
  resize_decrease_width = "resize --width -2%";
  resize_increase_width = "resize --width +2%";
  resize_decrease_height = "resize --height -2%";
  resize_increase_height = "resize --height +2%";
}