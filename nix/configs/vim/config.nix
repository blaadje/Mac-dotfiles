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
    vim-visual-multi
    comment-nvim
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
    bufferline-nvim
    incline-nvim
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
  keymaps = [
    {
      mode = "n";
      key = "<C-m>";
      action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<C-m>";
      action =
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
      options = {
        noremap = true;
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-Tab>";
      action = "<cmd>tabnext<CR>";
    }
    {
      mode = "n";
      key = "<C-S-Tab>";
      action = "<cmd>tabprev<CR>";
    }
    {
      mode = "n";
      key = "gd";
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
    }
    {
      mode = "n";
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
    }
    {
      mode = "n";
      key = "<A-Down>";
      action = "<cmd>MoveLine(1)<CR>";
    }
    {
      mode = "n";
      key = "<A-Up>";
      action = "<cmd>MoveLine(-1)<CR>";
    }
    {
      mode = "n";
      key = "<C-b>";
      action = "<cmd>NvimTreeToggle<CR>";
    }
    {
      mode = "n";
      key = "<C-p>";
      action = ''
        <cmd>lua require("telescope").extensions["recent-files"].recent_files({})<CR>'';
    }
    {
      mode = "n";
      key = "<C-e>";
      action = "<cmd>lua require('trouble').toggle()<CR>";
    }
    {
      mode = "n";
      key = "<C-w>";
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<Plug>(VM-Find-Under)";
      options = { noremap = false; };
    }
    {
      mode = "n";
      key = "<C-S-Down>";
      action = "<Plug>(VM-Add-Cursor-Down)";
      options = { noremap = false; };
    }
    {
      mode = "n";
      key = "<C-S-Up>";
      action = "<Plug>(VM-Add-Cursor-Up)";
      options = { noremap = false; };
    }
    {
      mode = "n";
      key = "<C-S-f>";
      action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>lua require('telescope.builtin').buffers()<CR>";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>lua require('telescope.builtin').help_tags()<CR>";
    }

    {
      mode = "i";
      key = "hh";
      action = "<Esc>";
    }
    {
      mode = "n";
      key = "hh";
      action = "<Esc>";
    }
    {
      mode = "v";
      key = "hh";
      action = "<Esc>";
    }
    {
      mode = "v";
      key = "<C-c>";
      action = "+y";
    }
    {
      mode = "n";
      key = "<S-Down>";
      action = "5j";
    }
    {
      mode = "n";
      key = "<S-Up>";
      action = "5k";
    }
  ];

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
