{ config, pkgs, lib, ... }:

let
  arrows = builtins.fromJSON (builtins.readFile ./arrows.json);
  numbers = builtins.fromJSON (builtins.readFile ./numbers.json);
  deviceSpecificMods = builtins.fromJSON (builtins.readFile ./device-specific-mods.json);
  simpleMods = builtins.fromJSON (builtins.readFile ./simple-mods.json);
  devices = builtins.fromJSON (builtins.readFile ./devices.json);
  
  karabinerConfig = {
    "global" = { "unsafe_ui" = true; };
    "profiles" = [
      {
        "complex_modifications" = {
          "rules" = [ arrows numbers deviceSpecificMods ];
        };
        "devices" = devices;
        "name" = "Default profile";
        "selected" = true;
        "simple_modifications" = simpleMods;
        "standalone_keys" = [];
        "virtual_hid_keyboard" = {
          "caps_lock_delay_milliseconds" = 0;
          "keyboard_type" = "ansi";
          "keyboard_type_v2" = "ansi";
        };
      }
    ];
  };
in
{
  home.file.".config/karabiner/karabiner.json" = {
    text = builtins.toJSON karabinerConfig;
  };
}