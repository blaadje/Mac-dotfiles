require('output')
require("gitsigns").setup()
local themeColors = require('base16-colorscheme').colors
require("nvim-autopairs").setup()
require("nvim-treesitter.configs").setup {
    autotag = {enable = true},
    highlight = {enable = true}

}
require("nvim-tree").setup({
    update_focused_file = {enable = true, update_root = false, ignore_list = {}},
    view = {adaptive_size = false, centralize_selection = false, width = 50},
    renderer = {
        highlight_git = true,
        root_folder_label = false,
        indent_markers = {enable = true}
    }
})
require("trouble").setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 80, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    cycle_results = true, -- cycle item list when reaching beginning or end of list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>", "<2-leftmouse>"}, -- jump to the diagnostic or open / close folds
        open_split = {"<c-x>"}, -- open buffer in new split
        open_vsplit = {"<c-v>"}, -- open buffer in new vsplit
        open_tab = {"<c-t>"}, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j", -- next item
        help = "?" -- help menu
    },
    multiline = true, -- render multi-line messages
    indent_lines = true, -- add an indent guide below the fold icons
    win_config = {border = "single"}, -- window configuration for floating windows. See |nvim_open_win()|.
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    include_declaration = {
        "lsp_references", "lsp_implementations", "lsp_definitions"
    }, -- for the given modes, include the declaration of the current symbol in the results
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = ""
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local colors = require('mycolors')
local open_after_tree = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    actions.close(prompt_bufnr)

    vim.defer_fn(function()
        vim.cmd("edit " .. vim.fn.fnameescape(entry.path or entry.value))
    end, 100)
end

vim.api.nvim_set_hl(0, "InclineNormal",
                    {fg = "#ffffff", bg = themeColors.base00, bold = true})
vim.api.nvim_set_hl(0, "InclineInsert",
                    {fg = "#000000", bg = "#fdd835", bold = true}) -- jaune
vim.api.nvim_set_hl(0, "InclineVisual",
                    {fg = "#ffffff", bg = "#43a047", bold = true}) -- vert
vim.api.nvim_set_hl(0, "InclineCommand",
                    {fg = "#ffffff", bg = "#1976d2", bold = true}) -- bleu
vim.api.nvim_set_hl(0, "InclineReplace",
                    {fg = "#ffffff", bg = "#e53935", bold = true}) -- rouge

require("incline").setup({
    render = function(props)
        local mode_map = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "V-LINE",
            ["\22"] = "V-BLOCK",
            c = "COMMAND",
            s = "SELECT",
            R = "REPLACE"
        }
        local hl_map = {
            n = "InclineNormal",
            i = "InclineInsert",
            v = "InclineVisual",
            V = "InclineVisual",
            ["\22"] = "InclineVisual",
            c = "InclineCommand",
            s = "InclineVisual",
            R = "InclineReplace"
        }

        local mode = vim.fn.mode()
        local hl = hl_map[mode] or "InclineNormal"

        return {{mode_map[mode] or mode, group = hl}}
    end,

    window = {
        placement = {vertical = "bottom", horizontal = "right"},
        margin = {horizontal = 0, vertical = 0}
    }
})

vim.opt.laststatus = 0

require('Comment').setup()

-- Use this to add more results without clearing the trouble list
require("telescope").setup({
    defaults = {
        -- mappings = {n = {["<C-e>"] = open_with_trouble}},
        mappings = {
            i = {["<CR>"] = open_after_tree},
            n = {["<CR>"] = open_after_tree}
        },
        file_ignore_patterns = {'node_modules'}
    },
    extensions = {
        frecency = {
            -- matcher = "fuzzy",
            default_workspace = "CWD",
            ignore_patterns = {'node_modules'},
            show_filter_column = false
        }
    }
})
require("telescope").load_extension("recent-files")
require('move').setup()
require('colorizer').setup()
require("yanky").setup()

require("lsp_lines").setup()
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = true
    })
vim.o.winbar = " "

require("bufferline").setup {
    options = {
        mode = "tabs",
        indicator = {style = "underline"},
        separator_style = "slant",
        style_preset = {
            require("bufferline").style_preset.no_italic,
            require("bufferline").style_preset.no_bold
        },
        padding = 2
        --  },
        --  highlights = {
        --    buffer_selected = {
        --      gui = "bold,underline",
        --    },
        --  },
    },
    highlights = {
        fill = {bg = themeColors.base00},
        background = {bg = themeColors.base00, fg = themeColors.base05},
        buffer_visible = {bg = themeColors.base00, fg = themeColors.base05},
        buffer = {bg = themeColors.base00, fg = themeColors.base05},
        buffer_selected = {
            bg = themeColors.base00,
            fg = themeColors.base05,
            bold = true,
            underline = true
        },
        separator = {bg = themeColors.base00, fg = themeColors.base00},
        separator_visible = {bg = themeColors.base00, fg = themeColors.base00},
        separator_selected = {bg = themeColors.base00, fg = themeColors.base00},
        close_button = {fg = themeColors.base05, bg = themeColors.base00},
        tab = {bg = themeColors.base00},
        tab_selected = {bg = themeColors.base00},
        tab_separator = {bg = themeColors.base00, fg = themeColors.base00},
        tab_separator_selected = {
            bg = themeColors.base00,
            fg = themeColors.base00
        }
    }
}

require("lsp_lines").setup()
vim.diagnostic.config({virtual_text = false, virtual_lines = true})

local lspconfig = require("lspconfig")
local rainbow_delimiters = require "rainbow-delimiters"
local hooks = require("ibl.hooks")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    local is_in_deno_repo = lspconfig.util.root_pattern('deno.json',
                                                        'import_map.json',
                                                        'deno.jsonc')(vim.fn
                                                                          .getcwd())
    local is_in_deno_part_of_repo = vim.fn.match(vim.fn.expand '%:p',
                                                 'supabase/functions') > -1

    if is_in_deno_repo or is_in_deno_part_of_repo then
        if client.name == 'tsserver' then
            client.stop()
            return
        end
    end

end

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll"
    })
  end,
  settings = {
    workingDirectory = {mode = "location"}
  },
  root_dir = function(fname)
    return lspconfig.util.root_pattern("node_modules/eslint")(fname)
        or lspconfig.util.root_pattern("package.json", ".git")(fname)
  end
}

lspconfig.denols.setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc",
                                           "import_map.json")
}

lspconfig.ts_ls.setup({
    on_attach = on_attach,
    single_file_support = false,
    -- root_dir = lspconfig.util.find_git_ancestor,
    root_dir = lspconfig.util.root_pattern("package.json"),
    filetypes = {
        "javascript", "typescript", "javascriptreact", "typescriptreact",
        "typescript.ts"
    },
    settings = {
        diagnostics = true,
        preferences = {includeCompletionsForImportStatements = true}
    }
})

lspconfig.ember.setup({on_attach = on_attach})

lspconfig.vuels.setup({
    on_attach = on_attach,
    init_options = {
        config = {
            vetur = {completion = {tagCasing = "pascal", autoImport = true}}
        }
    }
})

-- Autocomplete
cmp.setup({
    snippet = {
        expand = function(args)
            -- vim.snippet.expand(args.body)
            require("luasnip").lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({select = true}) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        {name = "nvim_lsp"}, {name = "buffer"},
        {name = "nvim_lsp_signature_help"}
    })
})

-- Formating

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.lua", "*.nix", "*.go"},
    command = "Neoformat"
})

require("ibl").setup {
    indent = {highlight = "Background"},
    scope = {highlight = colors.highlight}
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT,
               hooks.builtin.scope_highlight_from_extmark)

vim.g.rainbow_delimiters = {
    strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        commonlisp = rainbow_delimiters.strategy["local"]
    },
    query = {
        -- javascript = 'rainbow-parens',
        vue = "rainbow-parens",
        html = "rainbow-parens",
        jsx = "rainbow-parens",
        tsx = "rainbow-parens",
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks"
    },
    priority = {[""] = 110, lua = 210},
    blacklist = {"c", "cpp", "html"},
    highlight = colors.highlight
}

vim.o.ignorecase = true
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})

vim.o.hlsearch = false
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.keymap.set("n", " ", "<Nop>", {silent = true, remap = false})
vim.g.mapleader = " "

