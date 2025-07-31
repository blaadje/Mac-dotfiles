{ config, pkgs, lib, users, nix-colors, nixvim, ... }: {
  imports = [ nix-colors.homeManagerModule ./nix/darwin/services.nix ];

  system.primaryUser = "alexandre.charlot";

  users.users."alexandre.charlot".home = "/Users/alexandre.charlot";

  ids.gids.nixbld = 350;
  ids.uids.nixbld = 350;

  # colorScheme = nix-colors-lib.colorSchemeFromPicture {
  #   path = wallpaperPath;
  #   kind = "dark";
  # };

  # colorScheme = nix-colors.colorSchemes.katy;
  # colorScheme = nix-colors.colorSchemes.nova;
  colorScheme = nix-colors.colorSchemes.catppuccin-frappe;
  # colorScheme = nix-colors.colorSchemes.catppuccin-macchiato; # very nice one
  # colorScheme = nix-colors.colorSchemes.tokyo-night-dark;
  # colorScheme = nix-colors.colorSchemes.ocean;
  # colorScheme = nix-colors.colorSchemes.dracula;

  nixpkgs.overlays = [ (import ./nix/overlays) ];
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.bash.enable = true;
  
  # Set Fish as default shell
  users.users."alexandre.charlot".shell = pkgs.fish;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users."alexandre.charlot" = { lib, ... }:
    let
      fontConfig = {
        family = "MesloLGL Nerd Font";
        size = "15";
        package = pkgs.nerd-fonts.meslo-lg;
      };
    in {
      fonts = { fontconfig.enable = true; };

      imports = [
        nixvim.homeManagerModules.nixvim
        (import ./nix/common/packages.nix { inherit config pkgs lib fontConfig; })
        (import ./nix/darwin/packages.nix { inherit config pkgs lib fontConfig; })
        (import ./nix/configs/sketchybar/sketchybar.nix {
          inherit config pkgs lib fontConfig;
        })
        (import ./nix/configs/karabiner/karabiner.nix {
          inherit config pkgs lib;
        })
      ];

      home.sessionVariables.PATH =
        "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH";

      home.stateVersion = "23.05";
    };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    dock = {
      autohide = true;
      static-only = true;
      orientation = "left";
    };
    NSGlobalDomain = {
      _HIHideMenuBar = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.swipescrolldirection" = false;
      InitialKeyRepeat = 20;
      KeyRepeat = 1;
      ApplePressAndHoldEnabled = false;
    };
  };

  system.stateVersion = 4;

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
