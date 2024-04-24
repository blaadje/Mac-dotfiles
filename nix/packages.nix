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
    act # Local github actions
  ];

  commandLineTools = [
    htop
    watch
    neofetch
    autojump
    jq
    cloc
    nodePackages.git-run
    gitAndTools.delta
  ];

  web = [
    awscli
    awsebcli
    heroku
    netlify-cli
    nodePackages.http-server
    nodejs-16_x
    (yarn.override {
      nodejs = nodejs-16_x;
      # nodejs = nodejs-slim-14_x;
    })
  ];
in {
  home.packages = concatLists [
    # misc
    [ fzf ripgrep bat nixfmt mktemp tree unrar material-icons ]
    development
    commandLineTools
    web
  ];

  programs.autojump.enableFishIntegration = true;

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
