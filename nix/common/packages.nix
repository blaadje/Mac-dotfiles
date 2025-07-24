{ config, pkgs, lib, fontConfig, ... }:

with lib;
with pkgs;

let
  # Packages communs à macOS et Linux
  development = [
    deno
    docker
    watchman
    claude-code
    ember-cli
    watch
    cloc
    jq
    act
    nodePackages.git-run
    gitAndTools.delta
    tree-sitter
    luaformatter
    eslint_d
    prettierd
    nixfmt-classic
    pnpm
    sshfs
  ];

  lsp = [
    lua-language-server
    pyright
    deno
    nodePackages.vscode-langservers-extracted
    nodePackages.eslint
    nodePackages.typescript-language-server
    ember-language-server
    nil
  ];

  commandLineTools = [ 
    gtop 
    neofetch 
    nix-tree 
    btop 
    eza 
  ];

  node = nodejs_20;

  web = [
    heroku
    netlify-cli
    nodePackages.http-server
  ];

  # Pas de packages spécifiques ici - ils sont dans darwin/ et linux/

in {
  home.packages = development 
    ++ lsp 
    ++ commandLineTools 
    ++ web 
    ++ [ node ];

  # Configuration commune
  programs = {
    fish.enable = true;
    git = {
      enable = true;
      userName = "Alexandre Charlot";
      userEmail = "your-email@example.com";
      extraConfig = {
        push.default = "simple";
        pull.rebase = true;
      };
    };
    
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}