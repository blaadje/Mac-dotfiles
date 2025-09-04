{ lib, pkgs, }:

let
  wmUtils = import ./window-manager/wm-utils.nix { inherit lib; };
  modifiers = import ../darwin/modifiers.nix;

  directKeybinds = {
    "${modifiers.alt}+return" = "kitty";
    "${modifiers.alt}+q" =
      "osascript -e 'tell application (path to frontmost application as text) to quit'";
    "${modifiers.super}+l" = "pmset displaysleepnow";
  };
  wmGenericKeybinds =
    import ./window-manager/keybinds/window-manager-keybinds.nix {
      inherit lib pkgs modifiers;
    };
  wmCommandMap = (import ./window-manager/keybinds/aerospace-keybinds.nix {
    inherit lib pkgs;
  });
  # wmCommandMap = (import ./window-manager/keybinds/yabai-keybinds.nix { inherit lib pkgs; });

  wmKeybinds = wmUtils.mapWmKeybinds wmGenericKeybinds wmCommandMap;
  allKeybinds = wmKeybinds // directKeybinds;

  convertToSkhdSyntax = key:
    let
      parts = lib.splitString "+" key;
      modifiers = lib.init parts;
      keyName = lib.last parts;
      modifierStr = lib.concatStringsSep " + " modifiers;
    in if modifiers == [ ] then keyName else modifierStr + " - " + keyName;

  lines = lib.concatStringsSep "\n"
    (lib.mapAttrsToList (k: v: (convertToSkhdSyntax k) + " : " + v)
      allKeybinds);

in {
  skhdConfig = pkgs.runCommand "skhd-configuration" { } ''
              mkdir -p $out
              cat > $out/skhd-configuration <<'EOF'
    ${lines}
    EOF
  '';
}
