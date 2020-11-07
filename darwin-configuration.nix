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
      userSettings = import ./vscode.nix;
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
        co = "checkout";
        ci = "commit";
        st = "status";
      };
    };
  };
  
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
    config = import ./yabai.nix;
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
