{ config, pkgs }: {
  launchd = {
    enable = true;
    keepAlive = true;
  };
  userSettings = {
    after-login-command = [ ];
    after-startup-command =
      [ "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar" ];
    exec-on-workspace-change = [
      "/bin/bash"
      "-c"
      "${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
    ];

    accordion-padding = 30;
    default-root-container-layout = "tiles";
    default-root-container-orientation = "auto";

    automatically-unhide-macos-hidden-apps = false;

    on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

    key-mapping.preset = "qwerty";

    gaps = {
      inner = {
        horizontal = 10;
        vertical = 10;
      };
      outer = {
        left = 10;
        bottom = 10;
        top = 10;
        right = 10;
      };
    };
  };
}
