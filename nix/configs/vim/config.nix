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
    # lsp_lines-nvim # Inline diagnostics display (ErrorLens-style)
    # diagflow-nvim
    blink-cmp # Fast autocompletion engine
    luasnip # Snippet engine
  ];

  # 🧹 Formatting & Editing
  editingPlugins = with plugins; [
    neoformat # Formatter via external tools
    nvim-ts-autotag # Auto-close & rename tags (HTML/JSX)
    nvim-autopairs # Auto-insert pairs (brackets, quotes, etc.)
    yanky-nvim # Enhanced yank/paste with history
    vim-visual-multi
    comment-nvim
    resession-nvim # Session management
    vim-textobj-user # add personnalized shortcuts e.g vil
  ];

  # 🎨 UI & Visual Enhancements
  uiPlugins = with plugins; [
    base16-nvim # Base16 colorscheme support
    nvim-web-devicons # File icons
    vim-devicons # Legacy devicons support
    indent-blankline-nvim # Indentation guides
    nvim-colorizer-lua # Highlights color codes
    rainbow-delimiters-nvim # Bracket pair coloring
    vim-cursorword # Highlight word under cursor
    bufferline-nvim # Tabs
    incline-nvim # sticky bar displaying : INSERT, VISUAL etc.
    # dashboard-nvim # dashboard when opening nvim
    wilder-nvim # vim commands autocompletion
    satellite-nvim
    marks-nvim
    nvim-numbertoggle
  ];

  # 📁 Navigation & Search
  navPlugins = with plugins; [
    telescope-nvim # Fuzzy finder
    telescope-recent-files-nvim # Recent files in Telescope
    nvim-tree-lua # File explorer
    move-nvim # Move lines/blocks
    trouble-nvim # Diagnostics view
    telescope-fzf-native-nvim
  ];

  # 🛠 Language-Specific / Syntax
  langPlugins = with plugins; [
    nvim-treesitter.withAllGrammars # Tree-sitter with all grammars
    vim-nix # Nix language support
    tree-sitter-language-injection
  ];

  # 🔧 Git Integration
  gitPlugins = with plugins; [
    gitsigns-nvim # Git diff signs
    telescope-git-conflicts-nvim
    git-conflict-nvim
  ];

   # 🌳 Language Injection
   injectionPlugins = with custom-plugins; [
     tree-sitter-language-injection
   ];

   myVimPlugins = concatLists [
     lspPlugins
     editingPlugins
     uiPlugins
     navPlugins
     langPlugins
     gitPlugins
     injectionPlugins
   ];
in {
  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    numberwidth = 4;
    scrolloff = 999;
    clipboard = "";
    ruler = false;
    wrap = false;
  };

  extraPlugins = myVimPlugins;
  keymaps = import ./keybinds.nix;

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

     -- Use Fish for terminal in nvim
     vim.o.shell = "${pkgs.fish}/bin/fish"

    -- Disable nvim-tree auto opening when opening directory  
    vim.g.nvim_tree_hijack_netrw = 0

    -- Auto-start server for remote commands
    if vim.fn.has('nvim') and not vim.env.NVIM then
      local server_path = '/tmp/nvim-server-' .. vim.fn.getpid()
      vim.fn.serverstart(server_path)
      -- Export server path for terminal to use
      vim.env.NVIM_SERVER = server_path
    end
  '';

}
