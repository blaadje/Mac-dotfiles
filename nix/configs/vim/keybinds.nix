[
  # 🔍 Telescope / Search
  {
    mode = [ "n" ];
    key = "<C-S-f>";
    action =
      "<cmd>lua require('telescope.builtin').live_grep({  additional_args = function() return { '--fixed-strings' } end })<CR>";
    options = {
      noremap = true;
      silent = true;
    };
  }
  {
    mode = [ "n" ];
    key = "<C-p>";
    action = ''
      <cmd>lua require("telescope").extensions["recent-files"].recent_files({})<CR>'';
  }
  {
    mode = [ "n" ];
    key = "<leader>ff";
    action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
  }
  {
    mode = [ "n" ];
    key = "<leader>fb";
    action = "<cmd>lua require('telescope.builtin').buffers()<CR>";
  }
  {
    mode = [ "n" ];
    key = "<leader>fh";
    action = "<cmd>lua require('telescope.builtin').help_tags()<CR>";
  }

  # 📁 File Navigation
  {
    mode = [ "n" ];
    key = "<C-b>";
    action =
      "<cmd>lua local view = require('nvim-tree.view'); local was_open = view.is_visible(); vim.cmd('NvimTreeToggle'); if not was_open then vim.cmd('wincmd p') end<CR>";
    options = {
      desc = "Toggle NvimTree without focusing";
      silent = true;
    };
  }
  {
    mode = [ "n" ];
    key = "<C-e>";
    action = "<cmd>lua require('trouble').toggle()<CR>";
  }

  # 🏷️ LSP / Code Navigation
  {
    mode = [ "n" ];
    key = "gd";
    action = "<cmd>lua vim.lsp.buf.definition()<CR>";
  }
  {
    mode = [ "n" ];
    key = "gD";
    action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
  }

  # 📋 Multi-cursor / Selection
  {
    mode = [ "n" ];
    key = "<C-d>";
    action = "<Plug>(VM-Find-Under)";
    options = { noremap = false; };
  }
  {
    mode = [ "n" ];
    key = "<C-S-Down>";
    action = "<Plug>(VM-Add-Cursor-Down)";
    options = { noremap = false; };
  }
  {
    mode = [ "n" ];
    key = "<C-S-Up>";
    action = "<Plug>(VM-Add-Cursor-Up)";
    options = { noremap = false; };
  }

  # 🔄 Line Movement
  {
    mode = [ "n" ];
    key = "<A-Down>";
    action = "<cmd>MoveLine(1)<CR>";
  }
  {
    mode = [ "n" ];
    key = "<A-Up>";
    action = "<cmd>MoveLine(-1)<CR>";
  }

  # 🏃 Fast Movement
  {
    mode = [ "n" "i" "v" ];
    key = "<S-Down>";
    action = "5j";
  }
  {
    mode = [ "n" "i" "v" ];
    key = "<S-Up>";
    action = "5k";
  }

  # 🔀 Tab Navigation
  {
    mode = [ "n" ];
    key = "<C-Tab>";
    action = "<cmd>bnext<CR>";
  }
  {
    mode = [ "n" ];
    key = "<C-S-Tab>";
    action = "<cmd>bprevious<CR>";
  }
  {
    mode = [ "n" ];
    key = "<C-S-n>";
    action =
      "<cmd>lua local file = vim.fn.expand('%:p'); local path = file != '' && vim.fn.fnameescape(file) || ''; os.execute('kitty nvim ' + path + ' >/dev/null 2>&1 &')<CR>";
    options = {
      desc = "Open file in new Kitty window silently";
      silent = true;
    };
  }

  # 📄 Copy/Paste
  {
    mode = [ "v" ];
    key = "<C-c>";
    action = "+y";
  }

  # 🔄 Mode Switching - Quick Escape
  {
    mode = [ "i" "n" "v" ];
    key = "hh";
    action = "<Esc>";
  }

  # 🔄 Word Navigation (Normal Mode)
  {
    mode = [ "n" ];
    key = "<M-Left>";
    action = "b";
    options = { silent = true; };
  }
  {
    mode = [ "n" ];
    key = "<M-Right>";
    action = "w";
    options = { silent = true; };
  }
  {
    mode = [ "n" ];
    key = "<D-Left>";
    action = "^";
    options = { silent = true; };
  }
  {
    mode = [ "n" ];
    key = "<D-Right>";
    action = "$";
    options = { silent = true; };
  }

  # 🔄 Word Navigation (Insert Mode)
  {
    mode = [ "i" ];
    key = "<M-Left>";
    action = "<C-Left>";
    options = { silent = true; };
  }
  {
    mode = [ "i" ];
    key = "<M-Right>";
    action = "<C-Right>";
    options = { silent = true; };
  }
  {
    mode = [ "i" ];
    key = "<D-Left>";
    action = "<C-o>^";
    options = { silent = true; };
  }
  {
    mode = [ "i" ];
    key = "<D-Right>";
    action = "<C-o>$";
    options = { silent = true; };
  }

  # 🔄 Completion
  {
    mode = [ "i" ];
    key = "<C-i>";
    action = "<cmd>lua require('cmp').complete()<CR>";
    options = {
      noremap = true;
      silent = true;
    };
  }

  # 💬 Comments
  {
    mode = [ "n" ];
    key = "<CR>";
    action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
    options = {
      noremap = true;
      silent = true;
    };
  }
  {
    mode = [ "v" ];
    key = "<CR>";
    action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
    options = {
      noremap = true;
      silent = true;
    };
  }
]
