{  config, pkgs, lib, ... }:

{
  imports = [ <home-manager/nix-darwin> ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ./overlays) ];

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    dock = {
      autohide = true;
      static-only = true;
      orientation = "left";
    };
    NSGlobalDomain = {
      _HIHideMenuBar = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.swipescrolldirection" = false;
    };
  };

  programs.fish.enable = true;

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.alex = { pkgs, ... }: {
    home.packages = [
      pkgs.thefuck
      pkgs.fish
      pkgs.git
      pkgs.python3
      pkgs.htop
      pkgs.vscode
      pkgs.yabai
      pkgs.skhd
      pkgs.autojump
      pkgs.alacritty
      pkgs.nodejs
      pkgs.yarn
      pkgs.spacebar
      pkgs.starship
    ];

    programs.autojump.enableFishIntegration = true;
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "thefuck";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-thefuck";
            rev = "3570c4464bdfd0f312e22a0b407a8c0ba98b7e0d";
            sha256 = "0ih35vxvc05wc708i1ifr94s1p20k27bydqjlyk2gpv1cr8jf6j2";
          };
        }
      ];  
    };

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-utils;
        (extensionsFromVscodeMarketplace (import ./vscode/extensions.nix));
      userSettings = import ./vscode/settings.nix;
    };

    programs.alacritty = {
      enable = true;
      package = pkgs.alacritty;
      settings = import ./alacritty.nix;
    };

    programs.git = {
      package = pkgs.git;
      enable = true;
      userName = "blaadje";
      userEmail = "acharlot91@gmail.com";
      aliases = {
        st              = "status";
        ci              = "commit";
        co              = "checkout";
        br              = "branch";
        di              = "diff";
        sdi             = "diff --cached";
        dis             = "diff --ignore-all-space";
        logg            = "log --decorate --graph";
        lg              = "log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset%s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative";
        lga             = "!sh -c 'git log --author=\"$1\" -p $2' -";
        lol             = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola            = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        lint            = "!sh -c 'git status | awk \"/modified/ {print \\$3}\" | xargs -L 1 php -l'";
        logfull         = "log --pretty=fuller --graph --stat -p";
        cat             = "cat-file -p";
        unstage         = "reset HEAD";
        uncommit        = "update-ref HEAD HEAD^";
        uncommithard    = "reset --hard HEAD^";
        undomerge       = "reset --hard ORIG_HEAD";
        oups            = "commit -a --amend -C HEAD";
      };
    };
  };
  
  services.nix-daemon.enable = false;

  fonts = {
    enableFontDir = true;
    fonts = [
      pkgs.font-awesome
    ];
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = import ./spacebar.nix;
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = builtins.readFile ./shkd-configuration;
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = import ./yabai.nix;
    extraConfig = ''
      # rules
      yabai -m rule --add app="^System Preferences$" sticky=on
      yabai -m rule --add app="^Code$1" space=2
      yabai -m rule --add app="^Alacritty$1" space=3
      yabai -m rule --add app="^Google Chrome$1" space=1
    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
