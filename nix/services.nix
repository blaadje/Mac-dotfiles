{ config, pkgs, lib, ... }:
with lib;
let
  janky-borders = import ./derivations/jankyBorders.nix {
    inherit (pkgs) stdenv fetchFromGitHub gcc make darwin;
  };
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

  services.sketchybar = {
    enable = false; # config not working properly
    config = builtins.readFile ./configs/sketchybar/sketchybarrc;
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
