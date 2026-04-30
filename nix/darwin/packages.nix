{ config, pkgs, lib, fontConfig, ... }:

let
  # Packages spécifiques à macOS
in {
  home.packages = with pkgs; [
    moonlight-qt

    # Outils macOS spécifiques
    aerospace
    autoraise
    ccusage
    karabiner-elements
    macfuse-stubs
    # yabai
    # rift disabled in favour of aerospace, keep package available
    # rift

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
    # aerospace = (import ../configs/window-manager/aerospace.nix { inherit config pkgs; }) // {
    #   enable = true;
    # };

    sketchybar = {
      enable = true;
      service = { enable = true; };
    };

    kitty = (import ../configs/kitty.nix { inherit config fontConfig; }) // {
      enable = true;
    };
  };
}
