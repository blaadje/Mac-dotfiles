{ config, pkgs, lib, nix-colors, nixvim, ... }:

{
  imports = [
    nix-colors.homeManagerModules.default
    nixvim.homeManagerModules.nixvim
    (import ./nix/common/packages.nix {
      inherit config pkgs lib;
      fontConfig = {
        family = "MesloLGL Nerd Font";
        size = "15";
        package = pkgs.nerd-fonts.meslo-lg;
      };
    })
    (import ./nix/linux/packages.nix { inherit config pkgs lib; })
    (import ./nix/linux/services.nix { inherit config pkgs lib; })
  ];

  home = {
    username = "alexandre";
    homeDirectory = "/home/alexandre";
    stateVersion = "23.11";
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