{ config, pkgs, lib, ... }:
with lib;
let
  janky-borders = import ../derivations/jankyBorders.nix {
    inherit (pkgs) stdenv fetchFromGitHub gcc make darwin apple-sdk_15;
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

  # launchd.user.agents.autoraise = {
  #   serviceConfig.ProgramArguments = [
  #     "${pkgs.autoraise}/bin/AutoRaise"
  #     "-pollMillis"
  #     "20"
  #     "-disableKey"
  #     "disabled"
  #   ];
  #   serviceConfig.KeepAlive = true;
  #   serviceConfig.RunAtLoad = true;
  # };

  # Rift is already started by the app LaunchAgent (git.acsandmann.rift).
  # Keeping both this agent and the app agent enabled spawns two Rift instances.
  # launchd.user.agents.rift = {
  #   serviceConfig.ProgramArguments = [ "${pkgs.rift}/bin/rift" ];
  #   serviceConfig.KeepAlive = true;
  #   serviceConfig.RunAtLoad = true;
  # };

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

  services.skhd = let
    skhdModule = import ../configs/skhd-module.nix { inherit lib pkgs; };
    skhdConfigFile = "${skhdModule.skhdConfig}/skhd-configuration";
  in {
    # Disabled: we run skhd via the .app wrapper so TCC permissions apply.
    enable = true;
    skhdConfig = builtins.readFile skhdConfigFile;
  };

  services.yabai =
    (import ../configs/window-manager/yabai.nix { inherit config; }) // {
      # Disabled by default; enable when using yabai.
      enable = false;
    };

  # sketchybar is managed by home-manager program service
  # services.aerospace = (import ../configs/window-manager/aerospace.nix { inherit config pkgs; }) // {
  #   enable = true;
  # };
}
