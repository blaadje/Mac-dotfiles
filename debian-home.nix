{ config, pkgs, lib, nix-colors, nixvim, nurpkgs, ... }:

let
  fontConfig = {
    family = "MesloLGL Nerd Font";
    size = "15";
    package = pkgs.nerd-fonts.meslo-lg;
  };
in {
  imports = [
    nix-colors.homeManagerModules.default
    nixvim.homeManagerModules.nixvim
    (import ./nix/common/packages.nix { inherit config pkgs lib fontConfig nurpkgs; })
    (import ./nix/linux/packages.nix { inherit config pkgs lib fontConfig; })
    (import ./nix/linux/services.nix { inherit config pkgs lib; })
  ];

  home = {
    username = "aukx";
    homeDirectory = "/home/aukx";
    stateVersion = "23.11";
  };

  # Variables d'environnement WSL
  home.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "us";
    XKB_DEFAULT_VARIANT = "colemak";
    WAYLAND_DISPLAY = "";
    XDG_SESSION_TYPE = "x11";
    GDK_BACKEND = "x11";
    KITTY_DISABLE_WAYLAND = "1";
    FONTCONFIG_PATH = "${pkgs.fontconfig.out}/etc/fonts";
    FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
  };
  # Schéma de couleurs
  colorScheme = nix-colors.colorSchemes.catppuccin-frappe;

  fonts = { fontconfig.enable = true; };

  home.sessionVariables = {
    PATH = "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH";
  };

  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix flakes
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
