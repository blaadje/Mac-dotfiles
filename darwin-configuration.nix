{ config, pkgs, lib, users, nix-colors, nixvim, ... }:

let
  # wallpaperPath = ./paul-blenkhorn-cceo9QCekD0-unsplash.jpg;
  wallpaperPath = ./nix/assets/pawel-czerwinski-oykbZuvajO0-unsplash.jpg;
  # wallpaperPath = builtins.fetchurl {
  #   url = "https://wallpaperaccess.com/full/42259.jpg";
  #   sha256 = "19zqgy30dm266b2qjiacg8jgl5xcvd7hlc6g3vwlbnfhpaimccwj";
  # };

  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };

in {
  imports = [ nix-colors.homeManagerModule ./nix/services.nix ];

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
  # colorScheme = nix-colors.colorSchemes.tokyo-night-dark;
  # colorScheme = nix-colors.colorSchemes.ocean;
  colorScheme = nix-colors.colorSchemes.dracula;

  nixpkgs.overlays = [ (import ./nix/overlays) ];
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.bash.enable = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users."alexandre.charlot" = { lib, ... }: {
    fonts = { fontconfig.enable = true; };

    imports = [
      nixvim.homeManagerModules.nixvim
      (import ./nix/packages.nix { inherit config pkgs lib; })
      (import ./nix/configs/sketchybar/sketchybar.nix {
        inherit config pkgs lib;
      })
    ];

    home.sessionVariables.PATH =
      "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH";

    home.activation.changeWallpaper =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        bash ${./change-wallpaper.sh} "${wallpaperPath}"
      '';

    home.stateVersion = "23.05";
  };

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
    };
  };

  system.stateVersion = 4;
}
