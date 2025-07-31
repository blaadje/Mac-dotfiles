{ config, pkgs, lib, fontConfig, ... }:

let
  aerospaceConfig = import ../configs/aerospace.nix { inherit config pkgs; };

  # Packages spécifiques à macOS
in {
  home.packages = with pkgs; [
    # Outils macOS spécifiques
    aerospace
    autoraise
    ccusage
    karabiner-elements
    macfuse-stubs

    # iOS Development tools
    git-lfs
    rbenv
    ruby
    cocoapods
    fastlane
    mise
    gh

    # Fonts pour macOS
    fontConfig.package
  ];

  programs = {
    aerospace = aerospaceConfig // { enable = true; };

    sketchybar = {
      enable = true;
      service = { enable = true; };
    };

    kitty = (import ../configs/kitty.nix { inherit config fontConfig; }) // {
      enable = true;
    };
  };
}
