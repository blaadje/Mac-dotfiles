{ lib, pkgs ? import <nixpkgs> { }, modifiers }:

{
  # Focus movement
  "${modifiers.alt}+left" = "focus_left";
  "${modifiers.alt}+down" = "focus_down";
  "${modifiers.alt}+up" = "focus_up";
  "${modifiers.alt}+right" = "focus_right";

  # Move window
  "${modifiers.alt}+${modifiers.shift}+left" = "move_left";
  "${modifiers.alt}+${modifiers.shift}+down" = "move_down";
  "${modifiers.alt}+${modifiers.shift}+up" = "move_up";
  "${modifiers.alt}+${modifiers.shift}+right" = "move_right";

  # Workspaces
  "${modifiers.alt}+${modifiers.shift}+1" = "move_node_to_workspace_1";
  "${modifiers.alt}+${modifiers.shift}+2" = "move_node_to_workspace_2";
  "${modifiers.alt}+${modifiers.shift}+3" = "move_node_to_workspace_3";
  "${modifiers.alt}+${modifiers.shift}+4" = "move_node_to_workspace_4";
  "${modifiers.alt}+${modifiers.shift}+5" = "move_node_to_workspace_5";
  "${modifiers.alt}+${modifiers.shift}+6" = "move_node_to_workspace_6";

  "${modifiers.alt}+1" = "workspace_1";
  "${modifiers.alt}+2" = "workspace_2";
  "${modifiers.alt}+3" = "workspace_3";
  "${modifiers.alt}+4" = "workspace_4";
  "${modifiers.alt}+5" = "workspace_5";
  "${modifiers.alt}+6" = "workspace_6";

  # Window actions
  "${modifiers.alt}+f" = "toggle_fullscreen";
  "${modifiers.alt}+${modifiers.shift}+f" = "toggle_floating";
  "${modifiers.alt}+q" = "close_window";
  "${modifiers.alt}+enter" = "open_terminal";

  # Tree manipulation
  "${modifiers.alt}+r" = "rotate_tree";
  "${modifiers.alt}+j" = "join_left";

  # Resize windows
  "${modifiers.alt}+${modifiers.control}+left" = "resize_decrease_width";
  "${modifiers.alt}+${modifiers.control}+right" = "resize_increase_width";
  "${modifiers.alt}+${modifiers.control}+up" = "resize_decrease_height";
  "${modifiers.alt}+${modifiers.control}+down" = "resize_increase_height";
}
