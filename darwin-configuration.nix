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

  nixpkgs.overlays = [ (import ./nix/overlays) ];

  nixpkgs.config.allowUnfree = true;

  users.users.alex.home = "/Users/alex";

  nix.configureBuildUsers = true;

  programs.fish.enable = true; # Needed to be here for correct $NIX_PATH

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
    finder.AppleShowAllExtensions = true;
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
