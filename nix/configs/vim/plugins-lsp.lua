local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- LSP on_attach function
local on_attach = function(client, bufnr)
    -- Disable TS server in Deno projects
    local is_in_deno_repo = lspconfig.util.root_pattern('deno.json',
                                                        'import_map.json',
                                                        'deno.jsonc')(vim.fn
                                                                          .getcwd())
    local is_in_deno_part_of_repo = vim.fn.match(vim.fn.expand '%:p',
                                                 'supabase/functions') > -1

    if is_in_deno_repo or is_in_deno_part_of_repo then
        if client.name == 'ts_ls' then -- Updated from 'tsserver'
            client.stop()
            return
        end
    end

    -- Performance: Disable semantic tokens for large files
    if vim.api.nvim_buf_line_count(bufnr) > 10000 then
        client.server_capabilities.semanticTokensProvider = nil
    end
    
    -- Enable inlay hints if supported
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

-- ESLint configuration with async formatting
lspconfig.eslint.setup {
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                -- Async ESLint fix without blocking UI
                vim.lsp.buf.code_action({
                    context = {
                        only = {"source.fixAll.eslint"},
                        diagnostics = {}
                    },
                    apply = true
                })
            end
        })
    end,
    settings = {
        workingDirectory = {mode = "location"},
        codeActionOnSave = {
            enable = true,
            mode = "problems" -- Only fix problems, not all rules
        }
    },
    root_dir = function(fname)
        return lspconfig.util.root_pattern("node_modules/eslint")(fname) or
                   lspconfig.util.root_pattern("package.json", ".git")(fname)
    end
}

-- Configuration locale clangd pour WSL/CoD2 development
lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "clangd", "--background-index" },
    filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
    root_dir = lspconfig.util.root_pattern(
        "compile_commands.json",
        "compile_flags.txt", 
        ".git",
        "Makefile",
        "*.sln"
    ),
    settings = {
        clangd = {
            -- Configuration pour CoD2 .asi development (MinGW32)
            fallbackFlags = {
                "--target=i686-w64-mingw32",
                "-std=c++17",
                "-D_WIN32_WINNT=0x0601",
                "-D_WINDOWS",
                "-D_USRDLL",
                "-D_WINDLL",
                "-D_CRT_SECURE_NO_WARNINGS",
                "-D_WIN32_IE=0x0600",
                "-DWIN32_LEAN_AND_MEAN",
            },
        }
    }
}


lspconfig.nil_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {['nil'] = {formatting = {command = {"nixpkgs-fmt"}}}}
}

-- Deno LSP configuration
lspconfig.denols.setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
            preferences = {includeCompletionsForImportStatements = false},
            inlayHints = {
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            }
        }
    }
})

-- Ember LSP configuration
lspconfig.ember.setup({on_attach = on_attach, capabilities = capabilities})

-- Vue LSP configuration  
lspconfig.vuels.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        config = {
            vetur = {completion = {tagCasing = "pascal", autoImport = true}}
        }
    }
})

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT'},
            diagnostics = {
                globals = {'vim'},
                disable = {'missing-fields'} -- Reduce noise
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
                maxPreload = 100000,
                preloadFileSize = 10000
            },
            telemetry = {enable = false},
            hint = {
                enable = true -- Enable inlay hints
            }
        }
    }
}

-- Blink CMP configuration
require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ['<C-space>'] = {'show', 'show_documentation', 'hide_documentation'},
        ['<C-e>'] = {'hide', 'fallback'},
        ['<CR>'] = {'accept', 'fallback'},
        ['<Tab>'] = {'snippet_forward', 'fallback'},
        ['<S-Tab>'] = {'snippet_backward', 'fallback'},
        ['<Up>'] = {'select_prev', 'fallback'},
        ['<Down>'] = {'select_next', 'fallback'},
        ['<C-p>'] = {'select_prev', 'fallback'},
        ['<C-n>'] = {'select_next', 'fallback'},
        ['<C-b>'] = {'scroll_documentation_up', 'fallback'},
        ['<C-f>'] = {'scroll_documentation_down', 'fallback'}
    },

    appearance = {use_nvim_cmp_as_default = true, nerd_font_variant = 'mono'},

    sources = {default = {'lsp', 'path', 'snippets', 'buffer'}},

    completion = {
        accept = {auto_brackets = {enabled = true}},
        menu = {
            border = 'rounded', -- 'none', 'single', 'double', 'rounded', 'solid'
            winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
            draw = {
                treesitter = {"lsp"},
                columns = {
                    {"label", "label_description", gap = 1},
                    {"kind_icon", "kind"}
                }
            }
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
                border = 'rounded',
                winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:Visual,Search:None'
            }
        }
    },

    signature = {enabled = true}
})
