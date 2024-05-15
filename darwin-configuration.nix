{ config, pkgs, lib, users, ... }:
with lib;
let
  nix-colors = import <nix-colors> { };

  # wallpaperPath = ./paul-blenkhorn-cceo9QCekD0-unsplash.jpg;
  wallpaperPath = ./nix/assets/pawel-czerwinski-oykbZuvajO0-unsplash.jpg;
  # wallpaperPath = builtins.fetchurl {
  #   url = "https://wallpaperaccess.com/full/42259.jpg";
  #   sha256 = "19zqgy30dm266b2qjiacg8jgl5xcvd7hlc6g3vwlbnfhpaimccwj";
  # };

  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
in {
  imports = [
    <home-manager/nix-darwin>
    nix-colors.homeManagerModule
    ./nix/services.nix
  ];

  # colorScheme = nix-colors-lib.colorSchemeFromPicture {
  #   path = wallpaperPath;
  #   kind = "dark";
  # };

  #colorScheme = nix-colors.colorSchemes.katy;
  colorScheme = nix-colors.colorSchemes.ocean;
  #colorScheme = nix-colors.colorSchemes.dracula;
  #colorScheme = nix-colors.colorSchemes.edge-light;
  #colorScheme = nix-colors.colorSchemes.katy;

  # colorScheme = {

  #   slug = "pasque";
  #   name = "Pasque";
  #   author = "Gabriel Fontes (https://github.com/Misterio77)";
  #   palette = {
  #     base00 = "#282c34";
  #     base01 = "#353b45";
  #     base02 = "#3e4451";
  #     base03 = "#545862";
  #     base04 = "#565c64";
  #     base05 = "#abb2bf";
  #     base06 = "#b6bdca";
  #     base07 = "#c8ccd4";
  #     base08 = "#e06c75";
  #     base09 = "#d19a66";
  #     base0A = "#e5c07b";
  #     base0B = "#98c379";
  #     base0C = "#56b6c2";
  #     base0D = "#61afef";
  #     base0E = "#c678dd";
  #     base0F = "#be5046";
  #   };
  # };

  nixpkgs.overlays = [ (import ./nix/overlays) ];

  nixpkgs.config.allowUnfree = true;

  users.users.alex.home = "/Users/alex";

  nix.configureBuildUsers = true;

  programs.fish.enable = true; # Needed to be here for correct $NIX_PATH
  programs.bash.enable = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.alex = { lib, ... }: {
    fonts = { fontconfig.enable = true; };

    imports = [ (import ./nix/packages.nix { inherit config pkgs lib; }) ];

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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
