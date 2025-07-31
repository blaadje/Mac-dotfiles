{ config, pkgs, lib, fontConfig, ... }:

with lib;
with pkgs;

let
  # Import des configurations
  fishConfig = import ../configs/fish/config.nix { inherit config; };
  vscodeConfig =
    import ../configs/vscode/config.nix { inherit config pkgs lib; };
  kittyConfig = import ../configs/kitty.nix { inherit config fontConfig; };
  nixvimConfig = import ../configs/vim/config.nix { inherit config pkgs lib; };
  gitConfig = import ../configs/git.nix;

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

  commandLineTools = [ autojump btop eza gtop neofetch nix-tree ];

  node = nodejs_20;

  web = [ heroku netlify-cli nodePackages.http-server ];

  # Pas de packages spécifiques ici - ils sont dans darwin/ et linux/

in {
  home.packages = development ++ lsp ++ commandLineTools ++ web ++ [
    node
    fzf
    ripgrep
    bat
    mktemp
    tree
    unrar
    firefox-bin
    alacritty
    fontConfig.package
  ];

  # Alias pour utiliser la version système
  # home.shellAliases = { kitty = "/usr/bin/kitty"; };
  # Configuration commune
  programs = {
    fish = fishConfig // { enable = true; };

    autojump = {
      enable = true;
      enableFishIntegration = true;
    };
    git = gitConfig // { enable = true; };

    vscode = vscodeConfig // { enable = true; };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    # kitty = kittyConfig // { enable = true; };
    nixvim = nixvimConfig // { enable = true; };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
