{ config, pkgs, lib, ... }:

{
  # Services spécifiques à Linux/Ubuntu
  # Alternatives aux services macOS
  
  # Alternative à skhd : peut utiliser i3/sway bindings ou xbindkeys
  # Alternative à yabai : i3-wm, sway, ou hyprland
  
  # Exemple de configuration pour i3 (à adapter selon vos préférences)
  xsession = lib.mkIf (!config.wayland.windowManager.sway.enable) {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";  # Super key
        keybindings = let
          modifier = "Mod4";
        in {
          "${modifier}+Return" = "exec alacritty";
          "${modifier}+d" = "exec rofi -show run";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Exit i3?' -b 'Yes' 'i3-msg exit'";
          
          # Navigation entre fenêtres (comme yabai)
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          
          # Déplacer les fenêtres
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
        };
      };
    };
  };

  # Ou configuration Sway pour Wayland
  wayland.windowManager.sway = {
    enable = false;  # Mettre à true si vous préférez Wayland
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "rofi -show run";
    };
  };

  # Services système alternatifs
  services = {
    # Alternative à autoraise
    picom = {
      enable = true;
      fade = true;
      shadow = true;
    };
    
    # Gestionnaire de réseau
    network-manager-applet.enable = true;
    
    # Notifications
    dunst.enable = true;
  };

  # Configuration du clavier (alternative à Karabiner)
  home.keyboard = {
    layout = "us";
    options = [ "caps:escape" ];  # Caps Lock -> Escape
  };
}