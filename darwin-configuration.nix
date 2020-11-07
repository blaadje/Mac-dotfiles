{  config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nixpkgs.config.allowUnfree = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;

  programs.fish.enable = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.alex = { pkgs, ... }: {
    home.packages = [
      pkgs.fish
      pkgs.git
      pkgs.python3
      pkgs.htop
      pkgs.vscode
      pkgs.yabai
      pkgs.skhd
      pkgs.autojump
      pkgs.alacritty
      pkgs.chromium
      pkgs.nodejs
      pkgs.yarn
    ];


    programs.autojump.enableFishIntegration = true;

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.Nix
        # whizkydee.vscode-palenight-theme
      ];
      userSettings = {
        # editor settings
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.fontSize" = 14;
        "editor.lineHeight" = 24;
        "editor.fontLigatures" = false;
        "editor.cursorStyle" = "block";
        "editor.tabSize" = 2;
        "editor.rulers" = [80 100];

        # theme
        "workbench.activityBar.visible" = false;
        "workbench.colorTheme" = "Palenight Theme";
      };
    };

    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty;
      settings = {
        env = {
          "TERM" = "xterm-256color";
        };

        window = {
          padding.x = 15;
          padding.y = 15;
          decorations = "buttonless";
        };

        font = {
          size = 18.0;
          use_thin_strokes = true;

          normal.family = "FuraCode Nerd Font";
          bold.family = "FuraCode Nerd Font";
          italic.family = "FuraCode Nerd Font";
        };

        shell = {
          program = "/etc/profiles/per-user/alex/bin/fish";
        };

        colors = {
          # Default colors
          primary = {
            background = "0x1b182c";
            foreground = "0xcbe3e7";
          };

          # Normal colors
          normal = {
            black=   "0x3B4252";
            red=     "0xBF616A";
            green=   "0xA3BE8C";
            yellow=  "0xEBCB8B";
            blue=    "0x81A1C1";
            magenta= "0xB48EAD";
            cyan=    "0x88C0D0";
            white=   "0xE5E9F0";
          };

          # Bright colors
          bright = {
            black=   "0x4C566A";
            red=     "0xBF616A";
            green=   "0xA3BE8C";
            yellow=  "0xEBCB8B";
            blue=    "0x81A1C1";
            magenta= "0xB48EAD";
            cyan=    "0x8FBCBB";
            white=   "0xECEFF4";
          };
        };
      };
    };

    programs.git = {
      package = pkgs.git;
      enable = true;
      userName = "blaadje";
      userEmail = "acharlot91@gmail.com";
      aliases = {
        co = "checkout";
        ci = "commit";
        st = "status";
      };
    };
  };
  
  # services.nix-daemon.enable = true;
  services.nix-daemon.enable = false;

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = builtins.readFile ./shkd-configuration;
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      layout= "bsp";
      window_border= "on" ;
      window_border_width= 3;
      active_window_border_color= "0xff46d2f2";
      normal_window_border_color= "0xff5555"     ;
      window_placement= "second_child"     ;
      top_padding=    8;
      bottom_padding= 8;
      left_padding=   8;
      right_padding=  8;
      window_gap= 10;
      auto_balance= "on";
      split_ratio= "0";
      mouse_modifier= "fn";
      focus_follows_mouse= "autoraise";
      window_topmost= "on";
      window_shadow= "float";
      window_opacity= "off";
      active_window_opacity= "1.0";
      normal_window_opacity= "0.9";
    };

    extraConfig = ''
        # rules
        yabai -m rule --add app='System Preferences' manage=off

        # Any other arbitrary config here
      '';
  };
  

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
