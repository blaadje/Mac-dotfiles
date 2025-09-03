{ lib }:

{

  mapWmKeybinds = genericKeybinds: commandMap:
    lib.mapAttrs (key: action:
      let cmd = lib.attrByPath [ action ] null commandMap;
      in if cmd == null then "# MISSING: " + action else cmd) genericKeybinds;

  generateConfigLines = keybinds:
    lib.concatStringsSep "\n"
    (lib.mapAttrsToList (k: v: k + " : " + v) keybinds);
}
