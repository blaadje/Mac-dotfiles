{ config, pkgs, lib, ... }:
with lib;
let
  janky-borders = import ./derivations/jankyBorders.nix {
    inherit (pkgs) stdenv fetchFromGitHub gcc;
    make = pkgs.make;
    darwin = pkgs.darwin;
  };

  jankyBordersConfig = import ./configs/jankyBorders.nix { inherit config; };

in {
  services.nix-daemon.enable = true;

  services.karabiner-elements.enable = true;

  # custom service
  launchd.user.agents.jankyborders = {
    serviceConfig.ProgramArguments = [ "${janky-borders}/bin/jankyBorders" ]
      ++ mapAttrsToList (attr: value: "${attr}=${value}") jankyBordersConfig;
    serviceConfig.KeepAlive = true;
    serviceConfig.RunAtLoad = true;
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
