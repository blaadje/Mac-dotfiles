{ config, pkgs, lib, users, ... }:
with lib;
let
  custom-plugins = pkgs.callPackage ./vimcustomplugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
  };
  plugins = pkgs.vimPlugins // custom-plugins;

  myVimPlugins = with plugins; [
    nvim-base16
    fugitive
    material-vim
    indent-blankline-nvim
    vim-devicons
    nerdtree
    ghc-mod-vim
    haskell-vim
    LanguageClient-neovim
    nerdcommenter
    neomake
    polyglot
    ranger-vim
    rust-vim
    SpaceCamp
    syntastic
    vim-vue
    ctrlp-vim
    vim-nix
    vim-colorschemes
    vim-airline
    vim-airline-themes
    vim-autoformat
    YouCompleteMe
  ];

  nix-colors = import <nix-colors> { };

  janky-borders = import ./derivations/jankyBorders.nix {
    inherit (pkgs) stdenv fetchFromGitHub gcc;
    make = pkgs.make;
    darwin = pkgs.darwin;
  };

  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    ref = "nixos-23.05";
  });

  # wallpaperPath = ./paul-blenkhorn-cceo9QCekD0-unsplash.jpg;

  # wallpaperPath = ./pawel-czerwinski-oykbZuvajO0-unsplash.jpg;

  wallpaperPath = builtins.fetchurl {
    url =
      "http://wallup.net/wp-content/uploads/2016/01/151924-abstract-artwork-texture.jpg";
    sha256 = "19n5z5y36ahnfrvnhaa7vv9w4jwrgwiw5wrj7a237p7b04rysc6y";
  };

  nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
in {
  imports = [ <home-manager/nix-darwin> nix-colors.homeManagerModule ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ./overlays) ];
  users.nix.configureBuildUsers = true;

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.7"
    "nodejs-16.20.2"
    "nodejs-slim-14.21.3"
    "openssl-1.1.1w"
  ];

  # colorScheme = nix-colors-lib.colorSchemeFromPicture {
  #   path = wallpaperPath;
  #   kind = "light";
  # };

  colorScheme = nix-colors.colorSchemes.zenburn;

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

  users.users.alex.home = "/Users/alex";

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.alex = { lib, ... }:
    with pkgs; {
      imports = [ nixvim.homeManagerModules.nixvim ];

      home.activation.changeWallpaper =
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          bash ${./change-wallpaper.sh} "${wallpaperPath}"
        '';

      home.packages = [
        xcbuild
        janky-borders
        python2Full
        watch
        neofetch
        htop
        autojump
        act
        deno
        go
        jq
        fzf
        ripgrep
        bat
        nodejs-16_x
        # nodejs-slim-14_x
        (yarn.override {
          nodejs = nodejs-16_x;
          # nodejs = nodejs-slim-14_x;
        })
        # yarn
        # nodejs
        awscli
        # snapcraft
        nixfmt
        mktemp
        docker
        awsebcli
        tree
        unrar
        cloc
        heroku
        netlify-cli
        gitAndTools.delta
        nodePackages.git-run
        nodePackages.http-server
        # nerdfonts
        material-icons
        # nodePackages.npm
        # discord
      ];

      programs.nixvim = {
        enable = true;
        options = {
          number = true; # Show line numbers
          relativenumber = false; # Show relative line numbers

          shiftwidth = 2; # Tab width should be 2
        };
        extraPlugins = myVimPlugins;
        extraConfigLua = ''
          require("ibl").setup()
        '';
      };

      home.stateVersion = "23.05";

      programs.autojump.enableFishIntegration = true;

      programs.starship = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.fish = {
        enable = true;
        interactiveShellInit = import ./fish.nix { inherit config; };
        functions = {
          vi.body =
            "alacritty --title vimwindow --working-directory (pwd) -e nvim $argv &";
        };
      };

      programs.git.delta = {
        enable = true;
        options = { side-by-side = true; };
      };

      programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-utils;
          (extensionsFromVscodeMarketplace (import ./vscode/extensions.nix));
        userSettings = import ./vscode/settings.nix { inherit config; };
      };

      programs.alacritty = {
        enable = true;
        package = pkgs.alacritty;
        settings = import ./alacritty.nix { inherit config; };
      };

      programs.git = {
        enable = true;
        userName = "blaadje";
        userEmail = "acharlot91@gmail.com";
        extraConfig = { core = { ignoreCase = false; }; };
        aliases = {
          push = "push.default current";
          st = "status";
          ci = "commit";
          co = "checkout";
          br = "branch";
          di = "diff";
          sdi = "diff --cached";
          dis = "diff --ignore-all-space";
          logg = "log --decorate --graph";
          lg =
            "log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset%s %Cgreen(%an %cr)%Creset' --abbrev-commit --date=relative";
          lga = ''!sh -c 'git log --author="$1" -p $2' -'';
          lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
          lola =
            "log --graph --decorate --pretty=oneline --abbrev-commit --all";
          lint =
            "!sh -c 'git status | awk \"/modified/ {print \\$3}\" | xargs -L 1 php -l'";
          logfull = "log --pretty=fuller --graph --stat -p";
          cat = "cat-file -p";
          unstage = "reset HEAD";
          uncommit = "update-ref HEAD HEAD^";
          uncommithard = "reset --hard HEAD^";
          undomerge = "reset --hard ORIG_HEAD";
          oups = "commit -a --amend -C HEAD";
        };
      };

      fonts.fontconfig.enable = true;

    };

  fonts = { fontDir.enable = true; };

  services.nix-daemon.enable = true;

  services.karabiner-elements.enable = true;

  launchd.user.agents.jankyborders = {
    serviceConfig.ProgramArguments = [ "${janky-borders}/bin/jankyborders" ]
      ++ [ "width=6.0" "active_color=0xff00ff00" "inactive_color=0xff414550" ];
    serviceConfig.KeepAlive = true;
    serviceConfig.RunAtLoad = true;
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = import ./spacebar.nix { inherit config; };
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
    config = import ./yabai.nix { inherit config; };
    extraConfig = ''
      SPACEBAR_HEIGHT=$(spacebar -m config height)
      yabai -m config external_bar main:$SPACEBAR_HEIGHT:0
      # rules
      yabai -m rule --add app="^System Preferences$" sticky=on
      yabai -m rule --add title="^Todolist$" sticky=on
      yabai -m rule --add title="OBS.*" sticky=on
      yabai -m rule --add app="^Code$" space=2
      yabai -m rule --add title="vimwindow" space=2
    '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
