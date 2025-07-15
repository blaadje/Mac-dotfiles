{ config, pkgs, lib, ... }:
with lib;
let
  janky-borders = import ./derivations/jankyBorders.nix {
    inherit (pkgs) stdenv fetchFromGitHub gcc make darwin;
  };

in {
  system.primaryUser = "alexandre.charlot";

  # services.karabiner-elements.enable = true;

  # custom service
  launchd.user.agents.jankyborders = {
    serviceConfig.ProgramArguments = [ "${janky-borders}/bin/jankyBorders" ]
      ++ mapAttrsToList (attr: value: "${attr}=${value}")
      (import ./configs/jankyBorders.nix { inherit config; });
    serviceConfig.KeepAlive = true;
    serviceConfig.RunAtLoad = true;
  };

  launchd.user.agents.autoraise = {
    serviceConfig.ProgramArguments = [
      "${pkgs.autoraise}/bin/AutoRaise"
      "-pollMillis"
      "20"
      "-disableKey"
      "disabled"
    ];
    serviceConfig.KeepAlive = true;
    serviceConfig.RunAtLoad = true;
  };

  # Ne fonctionne pas avec les arrows / tous les inputs
  # launchd.user.agents.sketchyvim = {
  #   serviceConfig.ProgramArguments = [ "${sketchy-vim}/bin/svim" ];
  #   serviceConfig.KeepAlive = true;
  #   serviceConfig.RunAtLoad = true;
  # };

  # services.spacebar = {
  #   enable = false;
  #   package = pkgs.spacebar;
  #   config = import ./configs/spacebar.nix { inherit config; };
  # };

  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./configs/shkd-configuration;
  };

  # services.yabai = (import ./configs/yabai.nix { inherit config; }) // {
  # enable = true;
  # };
}
