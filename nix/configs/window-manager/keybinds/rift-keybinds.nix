{ lib, pkgs ? import <nixpkgs> { } }:

let riftCli = "${pkgs.rift}/bin/rift-cli";
in {
  focus_left = "${riftCli} execute window focus left";
  focus_down = "${riftCli} execute window focus down";
  focus_up = "${riftCli} execute window focus up";
  focus_right = "${riftCli} execute window focus right";

  move_left = "${riftCli} execute layout move-node left";
  move_down = "${riftCli} execute layout move-node down";
  move_up = "${riftCli} execute layout move-node up";
  move_right = "${riftCli} execute layout move-node right";

  move_node_to_workspace_1 = "${riftCli} execute workspace move-window 0";
  move_node_to_workspace_2 = "${riftCli} execute workspace move-window 1";
  move_node_to_workspace_3 = "${riftCli} execute workspace move-window 2";
  move_node_to_workspace_4 = "${riftCli} execute workspace move-window 3";
  move_node_to_workspace_5 = "${riftCli} execute workspace move-window 4";
  move_node_to_workspace_6 = "${riftCli} execute workspace move-window 5";

  workspace_1 = "${riftCli} execute workspace switch 0";
  workspace_2 = "${riftCli} execute workspace switch 1";
  workspace_3 = "${riftCli} execute workspace switch 2";
  workspace_4 = "${riftCli} execute workspace switch 3";
  workspace_5 = "${riftCli} execute workspace switch 4";
  workspace_6 = "${riftCli} execute workspace switch 5";

  toggle_fullscreen = "${riftCli} execute window toggle-fullscreen";
  toggle_floating = "${riftCli} execute window toggle-float";
  close_window =
    "osascript -e 'tell application (path to frontmost application as text) to quit'";
  open_terminal = "open -na kitty";

  rotate_tree = "${riftCli} execute layout toggle-orientation";
  join_left = "${riftCli} execute layout join-window left";

  resize_decrease_width = "${riftCli} execute window resize-shrink";
  resize_increase_width = "${riftCli} execute window resize-grow";
  resize_decrease_height = "${riftCli} execute window resize-shrink";
  resize_increase_height = "${riftCli} execute window resize-grow";
}
