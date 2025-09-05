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
    
    # Empêcher le switch automatique vers un autre workspace quand le workspace devient vide
    enable-normalization-flatten-containers = false;
    enable-normalization-opposite-orientation-for-nested-containers = false;

    on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

    key-mapping.preset = "qwerty";

    workspace-to-monitor-force-assignment = {
      "1" = 2;  # Workspace 1 → 27GN7
      "2" = 1;  # Workspace 2 → PHL 279P1 (forcer sa création)
      "3" = 1;  # Workspace 3 → PHL 279P1 (forcer sa création)
      "4" = 3;  # Workspaces 4,5,6 → Built-in Retina Display
      "5" = 3;
      "6" = 3;
    };

    gaps = {
      inner = {
        horizontal = 10;
        vertical = 10;
      };
      outer = {
        left = 10;
        top = [ { monitor."^built-in retina display$" = 10; } 34 ];
        bottom = 10;
        right = 10;
      };
    };
  };
}
