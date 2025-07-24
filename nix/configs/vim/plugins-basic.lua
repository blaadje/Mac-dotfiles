-- Plugins de base simples
require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>'
})
require("nvim-autopairs").setup()
require('Comment').setup()
require('move').setup()
require("yanky").setup()
require('colorizer').setup()
require("telescope").load_extension("conflicts")
-- Force git-conflict detection on common file types (removed - causing errors)

vim.api.nvim_set_hl(0, "GitConflictCurrent", {bg = "#6b7bad"})

vim.api.nvim_set_hl(0, "GitConflictIncoming", {bg = "#3c4841"})

vim.api.nvim_set_hl(0, "GitConflictAncestor", {bg = "#4c3a4c"})

require('git-conflict').setup({
    default_mappings = true, -- disable buffer local mapping created by this plugin
    default_commands = true, -- disable commands created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    list_opener = 'copen', -- command or function to open the conflicts list
    highlights = { -- They must have background color, otherwise the default color will be used
        current = "GitConflictCurrent",
        incoming = "GitConflictIncoming",
        ancestor = "GitConflictAncestor"
    }
})

-- Resession configuration for session management
local resession = require('resession')
resession.setup({
    -- Options for automatically saving sessions on a timer
    autosave = {enabled = true, interval = 60, notify = false},
    -- Save and restore these options
    options = {
        "binary", "bufhidden", "buflisted", "cmdheight", "diff", "filetype",
        "modifiable", "previewwindow", "readonly", "scrollbind", "winfixheight",
        "winfixwidth"
    },
    -- The name of the directory to store sessions in
    dir = "session",
    -- Configuration for extensions
    extensions = {quickfix = {}}
})

-- Auto-session per directory
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Count only real file arguments (not NvimTree, help, etc.)
        local real_files = 0
        for i = 0, vim.fn.argc(-1) - 1 do
            local arg = vim.fn.argv(i)
            -- Skip NvimTree and other special buffers
            if not string.match(arg, "^NvimTree_") and
                not string.match(arg, "^help:") and arg ~= "" then
                real_files = real_files + 1
            end
        end

        local should_load = real_files == 0 and not vim.g.using_stdin

        if should_load then
            -- Add a small delay to let Neovim stabilize
            vim.defer_fn(function()
                resession.load(vim.fn.getcwd(),
                               {dir = "dirsession", silence_errors = true})
            end, 100)
        end
    end,
    nested = true
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        resession.save(vim.fn.getcwd(), {dir = "dirsession", notify = false})
    end
})

vim.api.nvim_create_autocmd('StdinReadPre', {
    callback = function()
        -- Store this for later
        vim.g.using_stdin = true
    end
})

-- Telescope configuration
local actions = require('telescope.actions')

require('telescope').setup({
    defaults = {prompt_prefix = "🔍 ", selection_caret = "➤ "},
    pickers = {
        buffers = {
            sort_mru = true,
            sort_lastused = true,
            initial_mode = "normal",
            mappings = {
                n = {["d"] = actions.delete_buffer},
                i = {["<C-d>"] = actions.delete_buffer}
            }
        }
    }
})
