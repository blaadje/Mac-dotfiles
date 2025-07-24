{ config, pkgs, lib, ... }:

# Packages spécifiques à Linux
{
  home.packages = with pkgs; [
    # Clipboard pour Linux
    xclip
    wl-clipboard
    
    # Autres outils Linux spécifiques si nécessaire
  ];
}