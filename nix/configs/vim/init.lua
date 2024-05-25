require('output')
require("gitsigns").setup()
require("nvim-autopairs").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("lualine").setup {options = {theme = "base16"}}
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
-- Use this to add more results without clearing the trouble list
require("telescope").setup({
    defaults = {
        -- mappings = {n = {["<C-e>"] = open_with_trouble}},
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

local lspconfig = require("lspconfig")
local rainbow_delimiters = require "rainbow-delimiters"
local hooks = require("ibl.hooks")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local colors = require('mycolors')

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

    require("lsp-format").on_attach(client, bufnr)
end

require("mason-lspconfig").setup_handlers {
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end
}

lspconfig.eslint.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre",
                                    {buffer = bufnr, command = "EslintFixAll"})
    end,
    settings = {workingDirectory = {mode = 'location'}},
    root_dir = lspconfig.util.find_git_ancestor
}

lspconfig.denols.setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc",
                                           "import_map.json")
}

lspconfig.tsserver.setup({
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

require('keybinds')
