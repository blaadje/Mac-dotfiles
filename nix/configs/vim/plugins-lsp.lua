local lspconfig = require("lspconfig")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP on_attach function
local on_attach = function(client, bufnr)
    local is_in_deno_repo = lspconfig.util.root_pattern('deno.json', 'import_map.json', 'deno.jsonc')(vim.fn.getcwd())
    local is_in_deno_part_of_repo = vim.fn.match(vim.fn.expand '%:p', 'supabase/functions') > -1

    if is_in_deno_repo or is_in_deno_part_of_repo then
        if client.name == 'tsserver' then
            client.stop()
            return
        end
    end
end

-- ESLint configuration
lspconfig.eslint.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {buffer = bufnr, command = "EslintFixAll"})
    end,
    settings = {workingDirectory = {mode = "location"}},
    root_dir = function(fname)
        return lspconfig.util.root_pattern("node_modules/eslint")(fname) or
               lspconfig.util.root_pattern("package.json", ".git")(fname)
    end
}

-- Deno LSP configuration
lspconfig.denols.setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "import_map.json")
}

-- TypeScript LSP configuration
lspconfig.ts_ls.setup({
    on_attach = on_attach,
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("package.json"),
    filetypes = {"javascript", "typescript", "javascriptreact", "typescriptreact", "typescript.ts"},
    settings = {
        diagnostics = true,
        preferences = {includeCompletionsForImportStatements = true}
    }
})

-- Ember LSP configuration
lspconfig.ember.setup({on_attach = on_attach})

-- Vue LSP configuration
lspconfig.vuels.setup({
    on_attach = on_attach,
    init_options = {
        config = {
            vetur = {completion = {tagCasing = "pascal", autoImport = true}}
        }
    }
})

-- Autocompletion configuration
cmp.setup({
    snippet = {
        expand = function(args)
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
        ["<CR>"] = cmp.mapping.confirm({select = true})
    }),
    sources = cmp.config.sources({
        {name = "nvim_lsp"},
        {name = "buffer"},
        {name = "nvim_lsp_signature_help"}
    })
})