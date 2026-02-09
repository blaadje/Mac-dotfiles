{ config, pkgs, lib, ... }:

let
  riftConfig = ''
    [settings]
    animate = true
    animation_duration = 0.3
    animation_fps = 100.0
    animation_easing = "ease_in_out"
    focus_follows_mouse = true
    mouse_follows_focus = true
    mouse_hides_on_focus = true
    hot_reload = true
    default_disable = false
    run_on_start = [
      "${pkgs.rift}/bin/rift-cli subscribe cli --event workspace_changed --command sh --args -c --args '${pkgs.sketchybar}/bin/sketchybar --trigger wm_workspace_changed WM_WORKSPACE_NAME=\"$RIFT_WORKSPACE_NAME\"'",
    ]

    [settings.layout]
    mode = "bsp"

    [settings.layout.gaps.outer]
    top = 10
    left = 10
    bottom = 10
    right = 10

    [settings.layout.gaps.inner]
    horizontal = 10
    vertical = 10

    [virtual_workspaces]
    enabled = true
    default_workspace_count = 6
    auto_assign_windows = true
    preserve_focus_per_workspace = true
    workspace_auto_back_and_forth = false
    reapply_app_rules_on_title_change = false

    workspace_names = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6"
    ]

    app_rules = [
      { app_name = "Code", workspace = 1 },
      { title_regex = "vimwindow", workspace = 1 },
      { title_substring = "Todolist", floating = true },
      { title_regex = "OBS.*", floating = true },
      { app_name = "System Settings", floating = true },
      { app_name = "System Preferences", floating = true }
    ]

    [keys]
  '';
in {
  home.file.".config/rift/config.toml" = {
    text = riftConfig;
  };

  home.file."Applications/Rift.app/Contents/Info.plist" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundleDevelopmentRegion</key>
        <string>en</string>
        <key>CFBundleName</key>
        <string>Rift</string>
        <key>CFBundleDisplayName</key>
        <string>Rift</string>
        <key>CFBundleIdentifier</key>
        <string>local.nix.Rift</string>
        <key>CFBundleSignature</key>
        <string>????</string>
        <key>CFBundleVersion</key>
        <string>1.0</string>
        <key>CFBundleShortVersionString</key>
        <string>1.0</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleExecutable</key>
        <string>Rift</string>
      </dict>
      </plist>
    '';
  };

  home.file."Applications/Rift.app/Contents/PkgInfo" = {
    text = "APPL????";
  };

  home.file."Applications/Rift.app/Contents/MacOS/Rift" = {
    source = "${pkgs.rift}/bin/rift";
    executable = true;
  };

  home.file."Applications/Skhd.app/Contents/Info.plist" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleInfoDictionaryVersion</key>
        <string>6.0</string>
        <key>CFBundleDevelopmentRegion</key>
        <string>en</string>
        <key>CFBundleName</key>
        <string>Skhd</string>
        <key>CFBundleDisplayName</key>
        <string>Skhd</string>
        <key>CFBundleIdentifier</key>
        <string>local.nix.Skhd</string>
        <key>CFBundleSignature</key>
        <string>????</string>
        <key>CFBundleVersion</key>
        <string>1.0</string>
        <key>CFBundleShortVersionString</key>
        <string>1.0</string>
        <key>CFBundlePackageType</key>
        <string>APPL</string>
        <key>CFBundleExecutable</key>
        <string>Skhd</string>
      </dict>
      </plist>
    '';
  };

  home.file."Applications/Skhd.app/Contents/PkgInfo" = {
    text = "APPL????";
  };

  home.file."Applications/Skhd.app/Contents/MacOS/Skhd" = {
    source = "${pkgs.skhd}/bin/skhd";
    executable = true;
  };
}
