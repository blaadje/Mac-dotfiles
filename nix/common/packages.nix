{ config, pkgs, lib, fontConfig, nurpkgs, ... }:

with lib;
with pkgs;

let
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

  ai = [ nurpkgs.repos.charmbracelet.crush claude-code ];

in {
  home.packages = development ++ lsp ++ commandLineTools ++ web ++ ai ++ [
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

  programs = {
    fish = fishConfig // { enable = true; };

    autojump = {
      enable = true;
      enableFishIntegration = true;
    };
    git = gitConfig // { enable = true; };

    # vscode = vscodeConfig // { enable = true; };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    nixvim = nixvimConfig // { enable = true; };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
