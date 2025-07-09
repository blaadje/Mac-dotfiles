local lspconfig = require("lspconfig")
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP on_attach function
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

-- ESLint configuration
lspconfig.eslint.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre",
                                    {buffer = bufnr, command = "EslintFixAll"})
    end,
    settings = {workingDirectory = {mode = "location"}},
    root_dir = function(fname)
        return lspconfig.util.root_pattern("node_modules/eslint")(fname) or
                   lspconfig.util.root_pattern("package.json", ".git")(fname)
    end
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"cpp", "c", "h", "hpp"},
    callback = function()
        print("FileType autocmd triggered for: " .. vim.bo.filetype)

        local root_path = vim.fs.find({"compile_commands.json", ".git"},
                                      {upward = true})[1]
        local resolved_root_dir = ""
        if root_path then
            resolved_root_dir = vim.fs.dirname(root_path)
        else
            print("Could not find compile_commands.json or .git for root_dir.")
        end
        print("Resolved root_dir: " .. resolved_root_dir)

        local clients = vim.lsp.get_clients({name = "clangd-tcp"})
        if #clients > 0 then
            print("clangd-tcp already running.")
            return
        end

        local ok, err = pcall(function()
            vim.lsp.start({
                name = "clangd-tcp",
                cmd = vim.lsp.rpc.connect("192.168.1.215", 9000),
                root_dir = resolved_root_dir,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                on_init = function(client)
                    print("clangd connected with id: " .. client.id)
                end,
                on_attach = function(client, bufnr)
                    print("clangd attached to buffer " .. bufnr)
                end
            })

            print("vim.lsp.start called.")
        end)

        if not ok then
            vim.notify("Erreur lors du démarrage de clangd: " .. tostring(err),
                       vim.log.levels.ERROR)
        end
    end
})

lspconfig.nil_ls.setup {
    settings = {['nil'] = {formatting = {command = {"nixpkgs-fmt"}}}}
}

-- Deno LSP configuration
lspconfig.denols.setup {
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc",
                                           "import_map.json")
}

-- TypeScript LSP configuration
lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("package.json"),
    filetypes = {
        "javascript", "typescript", "javascriptreact", "typescriptreact"
    },
    init_options = {
        maxTsServerMemory = 8192,
        preferences = {
            includeCompletionsForImportStatements = false,
            disableSuggestions = false,
            includeCompletionsForModuleExports = false
        }
    },
    settings = {
        typescript = {
            preferences = {includeCompletionsForImportStatements = false}
        }
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

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT' -- utilisé par Neovim
            },
            diagnostics = {
                globals = {'vim'} -- pour éviter les erreurs "undefined global 'vim'"
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false -- désactiver l'avertissement sur des libs externes
            },
            telemetry = {
                enable = false -- pour ne pas envoyer de données
            }
        }
    }
}

-- Autocompletion configuration
cmp.setup({
    snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end
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
        {name = "nvim_lsp"}, {name = "buffer"},
        {name = "nvim_lsp_signature_help"}
    })
})
