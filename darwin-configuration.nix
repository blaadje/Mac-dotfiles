{ config, pkgs, lib, users, ... }:
with lib;
let
  nix-colors = import <nix-colors> { };

  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    ref = "nixos-23.05";
  });

  # wallpaperPath = ./paul-blenkhorn-cceo9QCekD0-unsplash.jpg;

  # wallpaperPath = ./pawel-czerwinski-oykbZuvajO0-unsplash.jpg;

  wallpaperPath = builtins.fetchurl {
    url = "https://wallpaperaccess.com/full/42259.jpg";
    sha256 = "19zqgy30dm266b2qjiacg8jgl5xcvd7hlc6g3vwlbnfhpaimccwj";
  };

  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
in {
  imports = [
    <home-manager/nix-darwin>
    nix-colors.homeManagerModule
    ./nix/services.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ./nix/overlays) ];
  users.nix.configureBuildUsers = true;

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.7"
    "nodejs-16.20.2"
    "nodejs-slim-14.21.3"
    "openssl-1.1.1w"
  ];

  # colorScheme = nix-colors-lib.colorSchemeFromPicture {
  #   path = wallpaperPath;
  #   kind = "dark";
  # };

  colorScheme = nix-colors.colorSchemes.zenburn;

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

  users.users.alex.home = "/Users/alex";

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.alex = { lib, ... }:
    with pkgs; {
      imports = [
        nixvim.homeManagerModules.nixvim
        (import ./nix/packages.nix { inherit config pkgs lib; })
      ];

      home.activation.changeWallpaper =
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          bash ${./change-wallpaper.sh} "${wallpaperPath}"
        '';

      home.stateVersion = "23.05";
      fonts.fontconfig.enable = true;
    };

  fonts = { fontDir.enable = true; };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
