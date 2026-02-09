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
        vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
    end

    -- Automatic hover on cursor hold
    -- if client.server_capabilities.hoverProvider then
    --     vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
    --         buffer = bufnr,
    --         callback = function()
    --             vim.lsp.buf.hover()
    --         end,
    --     })
    -- end
end

local clangd_cmd = {
    "/mnt/c/Users/aukx/projects/llvm-projects/build/build-mingw32/bin/clangd.exe",
    "--background-index",
    "--compile-commands-dir=C:\\Users\\aukx\\projects\\cod2-asi\\build",
    "--path-mappings=/mnt/c/=C:/,C:/=/mnt/c/",
    "--enable-config",
    "--clang-tidy",
    "--log=verbose",
    "--pretty"
}

lspconfig.clangd.setup({
    cmd = clangd_cmd,
    root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
    single_file_support = true,
    flags = {debounce_text_changes = 150, allow_incremental_sync = true},
    on_attach = on_attach
})

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
                includeInlayEnumMemberValueHints = true
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
