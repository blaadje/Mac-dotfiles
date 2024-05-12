{ config, pkgs, lib, ... }:
with lib;
let
  janky-borders = import ./derivations/jankyBorders.nix {
    inherit (pkgs) stdenv fetchFromGitHub gcc make darwin;
  };

  sketchy-vim = import ./derivations/sketchyVim.nix {
    inherit (pkgs) stdenv fetchFromGitHub;
  };

  folderPath = builtins.toString ./configs/sketchybar;

  logs = ./configs/sketchybar/foo.txt;
in {
  services.nix-daemon.enable = true;

  services.karabiner-elements.enable = true;

  # custom service
  launchd.user.agents.jankyborders = {
    serviceConfig.ProgramArguments = [ "${janky-borders}/bin/jankyBorders" ]
      ++ mapAttrsToList (attr: value: "${attr}=${value}")
      (import ./configs/jankyBorders.nix { inherit config; });
    serviceConfig.KeepAlive = true;
    serviceConfig.RunAtLoad = true;
  };

  launchd.user.agents.sketchybar.serviceConfig = {
    StandardErrorPath = logs;
    StandardInPath = logs;
    StandardOutPath = logs;
  };

  services.sketchybar = (import ./configs/sketchybar/config.nix) // {
    enable = false; # config not working properly
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = import ./configs/spacebar.nix { inherit config; };
  };

  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./configs/shkd-configuration;
  };

  services.yabai = (import ./configs/yabai.nix { inherit config; }) // {
    enable = true;
  };
}
