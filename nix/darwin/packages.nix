{ config, pkgs, lib, fontConfig, ... }:

# Packages spécifiques à macOS
{
  home.packages = with pkgs; [
    # Outils macOS spécifiques
    xcbuild
    autoraise
    macfuse-stubs
    ccusage
    
    # Fonts pour macOS
    fontConfig.package
  ];
}