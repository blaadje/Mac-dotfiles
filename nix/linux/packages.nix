{ config, pkgs, lib, fontConfig, ... }:

# Packages spécifiques à Linux
let kittyConfig = import ../configs/kitty.nix { inherit config fontConfig; };
in {
  home.packages = with pkgs; [
    # Clipboard pour Linux
    xclip
    wl-clipboard
    xorg.setxkbmap

    # LSP pour C++
    clang-tools
    cmake
    conan

    # Cross-compilation Windows 32-bit complet
    pkgs.pkgsCross.mingw32.stdenv.cc
    pkgs.pkgsCross.mingw32.windows.mingw_w64_headers

    # Build tools
    gnumake
    ninja
    pkg-config
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Configuration clavier Colemak si DISPLAY est défini
      if test -n "$DISPLAY"
          ${pkgs.xorg.setxkbmap}/bin/setxkbmap us -variant colemak -option caps:backspace 2>/dev/null
      end
    '';
  };

  home.file.".config/kitty/kitty.conf".text = let
    kittySettings = kittyConfig.settings;
    kittyExtra = kittyConfig.extraConfig;
  in ''
    # Configuration générée depuis Nix
    ${lib.concatStringsSep "\n"
    (lib.mapAttrsToList (name: value: "${name} ${toString value}")
      kittySettings)}

    # Configuration supplémentaire
    ${kittyExtra}

    # Ajouts spécifiques WSL
    linux_display_server x11
    # hide_window_decorations "no"
    font_size 20
  '';

}
