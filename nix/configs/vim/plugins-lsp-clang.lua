local changetracking = require('vim.lsp._changetracking')

local original_send_changes = changetracking.send_changes
local original_send_changes_for_group = changetracking.send_changes_for_group

local function buffer_uses_clangd(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({bufnr = bufnr})
    for _, client in ipairs(clients) do
        if client.name == "clangd" then return true end
    end
    return false
end

changetracking.send_changes = function() return end
changetracking.send_changes_for_group = function(group, states) return end
changetracking._get_and_set_name = function(bufnr, client_id, encoding)
    return "disabled_changetracking"
end
changetracking.reset = function() return end

local lspconfig = require('lspconfig')

local function wsl_request(method, callback)
    local params = vim.lsp.util.make_position_params(0, 'utf-16')
    vim.lsp.buf_request(0, method, params, function(err, result)
        if err or not result or vim.tbl_isempty(result) then return end
        local locations = vim.islist(result) and result or {result}
        for _, location in ipairs(locations) do
            if location.uri and location.uri:match('^file:///C:') then
                location.uri = location.uri:gsub('^file:///C:', 'file:///mnt/c')
            end
        end
        callback(locations)
    end)
end

local function jump_to_location(locations)
    local location = locations[1]
    if not location then return end
    local file_path = vim.uri_to_fname(location.uri)
    local line = location.range.start.line + 1
    local col = location.range.start.character + 1
    vim.cmd('drop ' .. vim.fn.fnameescape(file_path))
    vim.api.nvim_win_set_cursor(0, {line, col - 1})
end

local function list_locations(locations)
    local items = vim.lsp.util.locations_to_items(locations)
    vim.fn.setloclist(0, {}, 'r', {title = "LSP Results", items = items})
    vim.cmd('lopen')
end

local clangd_cmd = {
    "/mnt/c/Users/aukx/scoop/shims/clangd.exe", "--background-index",
    "--compile-commands-dir=C:/Users/aukx/projects/cod2-asi/build",
    "--query-driver=C:/Users/aukx/.config/mingw32/bin/g++.exe",
    "--path-mappings=/mnt/c/Users/aukx/projects/=C:/Users/aukx/projects/"
}

lspconfig.clangd.setup({
    cmd = clangd_cmd,
    capabilities = (function()
        local capabilities =
            require('vim.lsp.protocol').make_client_capabilities()
        capabilities.textDocument.synchronization = {
            dynamicRegistration = false,
            willSave = false,
            willSaveWaitUntil = false,
            didSave = true
        }
        return capabilities
    end)(),
    on_attach = function(client, bufnr)
        client.offset_encoding = "utf-16"
        client.server_capabilities.textDocumentSync = 1
        client.handlers["textDocument/didChange"] = function() end

        client.server_capabilities.semanticTokensProvider = nil

        vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})

        -- Alternative: forcer le semantic highlighting dès l'ouverture
        -- vim.defer_fn(function()
        --     if vim.api.nvim_buf_is_valid(bufnr) then
        --         vim.lsp.buf.semantic_tokens_full()
        --     end
        -- end, 200)

        local opts = {buffer = bufnr, silent = true, noremap = true}

        vim.keymap.set('n', 'gd', function()
            wsl_request('textDocument/definition', jump_to_location)
        end, opts)
        vim.keymap.set('n', 'gD', function()
            wsl_request('textDocument/declaration', jump_to_location)
        end, opts)
        vim.keymap.set('n', 'gt', function()
            wsl_request('textDocument/typeDefinition', jump_to_location)
        end, opts)
        vim.keymap.set('n', 'gi', function()
            wsl_request('textDocument/implementation', jump_to_location)
        end, opts)
        vim.keymap.set('n', 'gr', function()
            wsl_request('textDocument/references', list_locations)
        end, opts)

        vim.api.nvim_create_autocmd({"BufWritePost"}, {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf_notify(bufnr, "textDocument/didSave", {
                    textDocument = {uri = vim.uri_from_bufnr(bufnr)}
                })
            end
        })
    end,
    filetypes = {"cpp", "c", "h", "hpp"},
    root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git")
})

vim.api.nvim_create_user_command('RestoreChangetracking', function()
    changetracking.send_changes = original_send_changes
    changetracking.send_changes_for_group = original_send_changes_for_group
end, {})

vim.api.nvim_create_user_command('CheckChangetracking', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({bufnr = bufnr})
    print("=== État du changetracking ===")
    print("Buffer:", bufnr)
    print("Clients attachés:")
    for _, client in ipairs(clients) do
        print("  -", client.name, "ID:", client.id, "Encoding:",
              client.offset_encoding)
        print("    Sync mode:", client.server_capabilities.textDocumentSync)
        print("    Semantic tokens:", client.server_capabilities
                  .semanticTokensProvider and "enabled" or "disabled")
    end
    print("Uses clangd:", buffer_uses_clangd(bufnr))
end, {})

vim.api.nvim_create_user_command('ToggleSemanticHighlight', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({bufnr = bufnr, name = "clangd"})
    for _, client in ipairs(clients) do
        if client.server_capabilities.semanticTokensProvider then
            client.server_capabilities.semanticTokensProvider = nil
            print("Semantic highlighting désactivé")
        else
            client.server_capabilities.semanticTokensProvider = {
                legend = {tokenTypes = {}, tokenModifiers = {}},
                range = true,
                full = true
            }
            print("Semantic highlighting activé")
        end
        vim.cmd('edit')
    end
end, {})
