{ config, pkgs, lib, ... }:
with lib;
let
  janky-borders = import ../derivations/jankyBorders.nix {
    inherit (pkgs) stdenv fetchFromGitHub gcc make darwin;
  };

in {
  system.primaryUser = "alexandre.charlot";

  # services.karabiner-elements.enable = true;

  # custom service
  launchd.user.agents.jankyborders = {
    serviceConfig.ProgramArguments = [ "${janky-borders}/bin/jankyBorders" ]
      ++ mapAttrsToList (attr: value: "${attr}=${value}")
      (import ../configs/jankyBorders.nix { inherit config; });
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

  # Monitor watcher optimisé - détecte les changements de moniteurs
  launchd.user.agents.monitor-watcher = {
    serviceConfig.ProgramArguments = [
      "/bin/bash"
      "-c"
      ''
        prev_count=$(${pkgs.aerospace}/bin/aerospace list-monitors | wc -l)
        while true; do
          sleep 2
          current_count=$(${pkgs.aerospace}/bin/aerospace list-monitors | wc -l)
          if [ "$current_count" != "$prev_count" ]; then
            echo "$(date): Monitor count changed: $prev_count -> $current_count"
            ${pkgs.sketchybar}/bin/sketchybar --reload
            prev_count=$current_count
          fi
        done
      ''
    ];
    serviceConfig.KeepAlive = true;
    serviceConfig.RunAtLoad = true;
    serviceConfig.StandardOutPath = "/tmp/monitor-watcher.log";
    serviceConfig.StandardErrorPath = "/tmp/monitor-watcher-error.log";
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
    skhdConfig = builtins.readFile ../configs/shkd-configuration;
  };


  # services.yabai = (import ./configs/yabai.nix { inherit config; }) // {
  # enable = true;
  # };
}
