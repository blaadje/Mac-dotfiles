{ config, pkgs, lib, fontConfig, ... }:

with lib;
with pkgs;

let
  development = [
    xcbuild
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
    autoraise
    prettierd
    nixfmt
    pnpm
    sshfs
    macfuse-stubs
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

  commandLineTools = [ gtop neofetch nix-tree btop ];

  node = nodejs_20;

  web = [
    heroku
    netlify-cli
    nodePackages.http-server
    node
    (yarn.override { nodejs = node; })
  ];
in {
  home.packages = concatLists [
    [ fzf ripgrep bat mktemp tree unrar karabiner-elements fontConfig.package ]
    development
    commandLineTools
    web
    lsp
  ];

  programs.autojump = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.kitty = (import ./configs/kitty.nix { inherit config fontConfig; })
    // {
      enable = true;
    };

  programs.fish = (import ./configs/fish/config.nix { inherit config; }) // {
    enable = true;
  };

  programs.vscode =
    (import ./configs/vscode/config.nix { inherit pkgs config; }) // {
      enable = true;
    };

  programs.nixvim =
    (import ./configs/vim/config.nix { inherit config pkgs lib; }) // {
      enable = true;
    };

  programs.sketchybar = {
    enable = true;
    service = { enable = true; };
  };

  programs.aerospace = (import ./configs/aerospace.nix { inherit config pkgs; })
    // {
      enable = true;
    };

  programs.git = (import ./configs/git.nix) // { enable = true; };
}
