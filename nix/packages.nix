{ config, pkgs, lib, ... }:
with lib;
with pkgs;
let
  oldNodesPackages = import (builtins.fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/824421b1796332ad1bcb35bc7855da832c43305f.tar.gz";
  }) { config = { permittedInsecurePackages = [ "nodejs-16.20.0" ]; }; };

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

  sketchy-vim =
    import ./derivations/sketchyVim.nix { inherit (pkgs) stdenv fetchzip; };

  development = [
    # sketchy-vim
    xcbuild
    deno
    unstable.go
    docker
    watch
    cloc
    jq
    act # Local github actions
    nodePackages.git-run
    gitAndTools.delta
    tree-sitter

    # formatters
    luaformatter
    eslint_d
    prettierd
    nixfmt
  ];

  commandLineTools = [ htop neofetch awscli awsebcli sketchybar ];

  node = nodejs_20;
  # node = oldNodesPackages.nodejs_16;

  web = [
    heroku
    netlify-cli
    nodePackages.http-server
    node
    (yarn.override { nodejs = node; })
  ];

  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    ref = "nixos-23.05";
  });
in {
  imports = [ nixvim.homeManagerModules.nixvim ];

  home.packages = concatLists [
    # misc
    [
      fzf
      ripgrep
      bat
      nixfmt
      mktemp
      tree
      unrar
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ]
    development
    commandLineTools
    web
  ];

  programs.autojump = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.kitty = (import ./configs/kitty.nix { inherit config; }) // {
    enable = true;
  };

  programs.fish = (import ./configs/fish/config.nix { inherit config; }) // {
    enable = true;
  };

  programs.vscode =
    (import ./configs/vscode/config.nix { inherit pkgs config; }) // {
      enable = true;
    };

  programs.nixvim = (import ./configs/vim/config.nix { inherit config pkgs; })
    // {
      enable = true;
    };

  # programs.alacritty = (import ./configs/alacritty.nix { inherit config; }) // {
  ##   package = pkgs.alacritty;
  ##   enable = true;
  ## };

  programs.git = (import ./configs/git.nix) // { enable = true; };
}
