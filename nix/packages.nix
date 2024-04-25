{ config, pkgs, lib, ... }:
with lib;
with pkgs;
let
  development = [
    xcbuild
    python2Full
    deno
    go
    docker
    watch
    cloc
    jq
    act # Local github actions
    nodePackages.git-run
    gitAndTools.delta
  ];

  commandLineTools = [ htop neofetch awscli awsebcli ];

  node = nodejs-16_x;
  # node = nodejs-slim-14_x;

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
    [ fzf ripgrep bat nixfmt mktemp tree unrar material-icons ]
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

  programs.fish = (import ./configs/fish/config.nix { inherit config; }) // {
    enable = true;
  };

  programs.vscode =
    (import ./configs/vscode/config.nix { inherit pkgs config; }) // {
      enable = true;
    };

  programs.nixvim = (import ./configs/vim/config.nix { inherit pkgs; }) // {
    enable = true;
  };

  programs.alacritty = (import ./configs/alacritty.nix { inherit config; }) // {
    enable = true;
  };

  programs.git = (import ./configs/git.nix) // { enable = true; };
}
