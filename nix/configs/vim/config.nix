{ pkgs, lib, config, ... }:

with lib;

let
  custom-plugins = pkgs.callPackage ./customPlugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
    inherit (pkgs) fetchFromGitHub;
  };

  plugins = pkgs.vimPlugins // custom-plugins;
  folderPath = builtins.toString ./.;

  # 🧠 LSP & Autocompletion
  lspPlugins = with plugins; [
    nvim-lspconfig # LSP client configuration for Neovim
    lsp_lines-nvim # Inline diagnostics display (ErrorLens-style)
    nvim-cmp # Autocompletion engine
    cmp-nvim-lsp # LSP source for nvim-cmp
    luasnip # Snippet engine
  ];

  # 🧹 Formatting & Editing
  editingPlugins = with plugins; [
    neoformat # Formatter via external tools
    nvim-ts-autotag # Auto-close & rename tags (HTML/JSX)
    nvim-autopairs # Auto-insert pairs (brackets, quotes, etc.)
    yanky-nvim # Enhanced yank/paste with history
  ];

  # 🎨 UI & Visual Enhancements
  uiPlugins = with plugins; [
    base16-nvim # Base16 colorscheme support
    nvim-web-devicons # File icons
    vim-devicons # Legacy devicons support
    lualine-nvim # Statusline
    indent-blankline-nvim # Indentation guides
    nvim-colorizer-lua # Highlights color codes
    rainbow-delimiters-nvim # Bracket pair coloring
    vim-cursorword # Highlight word under cursor
  ];

  # 📁 Navigation & Search
  navPlugins = with plugins; [
    telescope-nvim # Fuzzy finder
    telescope-recent-files-nvim # Recent files in Telescope
    nvim-tree-lua # File explorer
    move-nvim # Move lines/blocks
    trouble-nvim # Diagnostics view
  ];

  # 🛠 Language-Specific / Syntax
  langPlugins = with plugins; [
    nvim-treesitter.withAllGrammars # Tree-sitter with all grammars
    vim-nix # Nix language support
  ];

  # 🔧 Git Integration
  gitPlugins = with plugins;
    [
      gitsigns-nvim # Git diff signs
    ];

  # 📦 Final list
  myVimPlugins = concatLists [
    lspPlugins
    editingPlugins
    uiPlugins
    navPlugins
    langPlugins
    gitPlugins
  ];
in {
  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    numberwidth = 4;
    scrolloff = 999;
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
