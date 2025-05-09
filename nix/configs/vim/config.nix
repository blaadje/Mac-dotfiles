{ pkgs, config, ... }:
with pkgs;
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

  custom-plugins = callPackage ./customPlugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
    inherit (pkgs) fetchFromGitHub;
  };

  plugins = vimPlugins // custom-plugins;

  folderPath = builtins.toString ./.;

  myVimPlugins = with plugins; [
    base16-nvim
    vim-nix
    nvim-treesitter.withAllGrammars
    rainbow-delimiters-nvim
    unstable.vimPlugins.indent-blankline-nvim
    unstable.vimPlugins.yanky-nvim
    telescope-nvim
    nvim-web-devicons
    mason-nvim
    mason-lspconfig-nvim
    nvim-lspconfig
    nvim-cmp
    cmp-nvim-lsp
    neoformat
    gitsigns-nvim
    nvim-ts-autotag
    nvim-autopairs
    luasnip # Snippet for autocomplete
    lualine-nvim
    telescope-recent-files-nvim
    move-nvim # move line with arrow keys
    feline-nvim
    # pears-nvim
    vim-devicons
    # nerdtree
    # vim-wordmotion # words motions working with lettercasing
    # hover-nvim
    nvim-colorizer-lua
    trouble-nvim
    nvim-tree-lua
    vim-cursorword
    # ghc-mod-vim
    # haskell-vim
    # LanguageClient-neovim
    # nerdcommenter
    # neomake
    # polyglot
    # ranger-vim
    # rust-vim
    # SpaceCamp
    # syntastic
    # vim-vue
    # ctrlp-vim
    # vim-airline
    # vim-airline-themes
    # vim-autoformat
    # YouCompleteMe (failing deps)
  ];
in {
  options = {
    number = true; # Show line numbers
    relativenumber = true; # Show relative line numbers
    shiftwidth = 2; # Tab width should be 2
    numberwidth = 4;
    scrolloff = 999;
    #  scroll = 40;
  };
  extraPlugins = myVimPlugins;
  extraConfigLua = ''
    package.path = package.path .. ";${folderPath}/?.lua"

    require('base16-colorscheme').setup({
      base00 = "#${config.colorScheme.palette.base00}",
      base01 = "#${config.colorScheme.palette.base01}",
      base02 = "#${config.colorScheme.palette.base02}",
      base03 = "#${config.colorScheme.palette.base03}",
      base04 = "#${config.colorScheme.palette.base04}",
      base05 = "#${config.colorScheme.palette.base05}",
      base06 = "#${config.colorScheme.palette.base06}",
      base07 = "#${config.colorScheme.palette.base07}",
      base08 = "#${config.colorScheme.palette.base08}",
      base09 = "#${config.colorScheme.palette.base09}",
      base0A = "#${config.colorScheme.palette.base0A}",
      base0B = "#${config.colorScheme.palette.base0B}",
      base0C = "#${config.colorScheme.palette.base0C}",
      base0D = "#${config.colorScheme.palette.base0D}",
      base0E = "#${config.colorScheme.palette.base0E}",
      base0F = "#${config.colorScheme.palette.base0F}",
    })



    require("init")
  '';
}
