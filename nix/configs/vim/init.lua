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
require("telescope").setup({
    defaults = {file_ignore_patterns = {'node_modules'}},
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
require('nvim-highlight-colors').setup()

local builtin = require("telescope.builtin")
local lspconfig = require("lspconfig")
local rainbow_delimiters = require "rainbow-delimiters"
local hooks = require("ibl.hooks")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local colors = require('mycolors')

local on_attach = function(client, bufnr)
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

vim.diagnostic.config({
    float = {focusable = true, style = "minimal", border = "rounded"},
    diagnostic = {
        -- virtual_text = true,
        virtual_text = {spacing = 4, prefix = "●"},
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {focusable = true, style = "minimal", border = "rounded"}
    }
})

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        typescript = {tsserver = {trace = true, logVerbosity = "verbose"}}
    }
}

lspconfig.eslint.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre",
                                    {buffer = bufnr, command = "EslintFixAll"})
    end,
    settings = {workingDirectory = {mode = 'location'}},
    root_dir = lspconfig.util.find_git_ancestor
}

lspconfig.tsserver.setup({
    on_attach = on_attach,
    single_file_support = false,
    root_dir = lspconfig.util.find_git_ancestor,
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
    init_options = {config = {vetur = {completion = {autoImport = true}}}}
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

-- Colors

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
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks"
    },
    priority = {[""] = 110, lua = 210},
    blacklist = {"c", "cpp", "html"},
    highlight = colors.highlight
}

require('keybinds')

vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
