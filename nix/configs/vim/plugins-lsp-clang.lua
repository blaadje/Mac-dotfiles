-- clangd (WSL <-> Windows) — scope strict: C/C++ only, no global monkey-patching
local lspconfig = require('lspconfig')

-- ===================== Helpers (WSL path fix + navigation) =====================
local function wsl_request(method, callback)
    local ok_params, params = pcall(vim.lsp.util.make_position_params, 0,
                                    'utf-16')
    if not ok_params then return end
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
    local ok_fname, file_path = pcall(vim.uri_to_fname, location.uri)
    if not ok_fname then return end
    local line = (location.range and location.range.start and
                     location.range.start.line or 0) + 1
    local col = (location.range and location.range.start and
                    location.range.start.character or 0) + 1
    vim.cmd('drop ' .. vim.fn.fnameescape(file_path))
    pcall(vim.api.nvim_win_set_cursor, 0, {line, col - 1})
end

local function list_locations(locations)
    local ok_items, items = pcall(vim.lsp.util.locations_to_items, locations)
    if not ok_items then return end
    vim.fn.setloclist(0, {}, 'r', {title = 'LSP Results', items = items})
    vim.cmd('lopen')
end

-- ===================== clangd.exe configuration (Windows) =====================
local clangd_cmd = {
    '/mnt/c/Users/aukx/scoop/shims/clangd.exe', '--background-index',
    '--compile-commands-dir=C:/Users/aukx/projects/cod2-asi/build',
    '--query-driver=C:/Users/aukx/.config/mingw32/bin/g++.exe',
    '--path-mappings=/mnt/c/=C:/', '--log=error' -- reduce noisy logs
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
        if not client or client.name ~= 'clangd' then return end

        -- Encoding + sync mode (full)
        client.offset_encoding = 'utf-16'
        client.server_capabilities.textDocumentSync = 1

        -- Disable semantic tokens (optional)
        client.server_capabilities.semanticTokensProvider = nil

        -- Drop ONLY didChange for THIS client (save-driven workflow)
        if not client._original_notify then
            client._original_notify = client.notify
            client.notify = function(self, method, params)
                if method == 'textDocument/didChange' then return end
                return self._original_notify(self, method, params)
            end
        end

        -- Inlay hints (protected)
        pcall(function() vim.lsp.inlay_hint.enable(true, {bufnr = bufnr}) end)

        -- Send didSave after each write
        vim.api.nvim_create_autocmd('BufWritePost', {
            buffer = bufnr,
            callback = function()
                local uri = vim.uri_from_bufnr(bufnr)
                vim.lsp.buf_notify(bufnr, 'textDocument/didSave',
                                   {textDocument = {uri = uri}})
            end
        })

        -- Buffer-local keymaps (C/C++ only)
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
    end,
    filetypes = {'cpp', 'c', 'h', 'hpp'},
    root_dir = lspconfig.util.root_pattern('compile_commands.json', '.git')
})

-- ===================== Ensure didOpen across restarts/switches =====================
local function ensure_clangd_open(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].buftype ~= '' then return end
    if vim.b[bufnr].clangd_didopen_sent then return end
    local clients = vim.lsp.get_clients({bufnr = bufnr, name = 'clangd'})
    if #clients == 0 then return end -- clangd not attached
    local ok, params = pcall(vim.lsp.util.make_text_document_params, bufnr)
    if not ok then return end
    vim.lsp.buf_notify(bufnr, 'textDocument/didOpen', params)
    vim.b[bufnr].clangd_didopen_sent = true
end

-- Re-open on LspAttach (covers :LspRestart)
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= 'clangd' then return end
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype
        if ft ~= 'c' and ft ~= 'cpp' and ft ~= 'h' and ft ~= 'hpp' then
            return
        end
        vim.defer_fn(function()
            ensure_clangd_open(bufnr)
            -- (Re)enable inlay hints after didOpen to avoid races
            pcall(function()
                vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
            end)
        end, 10)
    end
})

-- Clean flag on detach to be ready for next attach
vim.api.nvim_create_autocmd('LspDetach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'clangd' then
            pcall(function()
                vim.b[args.buf].clangd_didopen_sent = nil
            end)
        end
    end
})

-- Safety net when entering C/C++ buffers (only if clangd is attached)
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
    pattern = {'*.c', '*.cpp', '*.h', '*.hpp'},
    callback = function(args)
        vim.defer_fn(function() ensure_clangd_open(args.buf) end, 20)
    end
})

-- ===================== Utility commands =====================
vim.api.nvim_create_user_command('CheckClangdSync', function()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(vim.lsp.get_clients({bufnr = bufnr})) do
        if client.name == 'clangd' then
            print('clangd#' .. client.id, 'offset:', client.offset_encoding,
                  'sync:', client.server_capabilities.textDocumentSync,
                  'semanticTokens:', client.server_capabilities
                      .semanticTokensProvider and 'on' or 'off',
                  'dropDidChange:', client._original_notify and 'on' or 'off',
                  'didOpenSent:',
                  vim.b[bufnr].clangd_didopen_sent and 'yes' or 'no')
        end
    end
end, {})

vim.api.nvim_create_user_command('ToggleClangdDidChange', function()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(vim.lsp
                                .get_clients({bufnr = bufnr, name = 'clangd'})) do
        if client._original_notify then
            client.notify = client._original_notify
            client._original_notify = nil
            print('clangd: didChange restauré')
        else
            local orig = client.notify
            client._original_notify = orig
            client.notify = function(self, method, params)
                if method == 'textDocument/didChange' then return end
                return orig(self, method, params)
            end
            print('clangd: didChange coupé')
        end
    end
end, {})

vim.api.nvim_create_user_command('ToggleClangdSemanticHighlight', function()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(vim.lsp
                                .get_clients({bufnr = bufnr, name = 'clangd'})) do
        if client.server_capabilities.semanticTokensProvider then
            client.server_capabilities.semanticTokensProvider = nil
            print('clangd: semantic highlighting désactivé')
        else
            client.server_capabilities.semanticTokensProvider = {
                legend = {tokenTypes = {}, tokenModifiers = {}},
                range = true,
                full = true
            }
            print('clangd: semantic highlighting activé')
        end
        vim.cmd('edit')
    end
end, {})

vim.api.nvim_create_user_command('ClangdReopen', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({bufnr = bufnr, name = 'clangd'})
    if #clients == 0 then return end
    local ok, params = pcall(vim.lsp.util.make_text_document_params, bufnr)
    if not ok then return end
    vim.lsp.buf_notify(bufnr, 'textDocument/didClose',
                       {textDocument = params.textDocument})
    vim.lsp.buf_notify(bufnr, 'textDocument/didOpen', params)
    vim.b[bufnr].clangd_didopen_sent = true
    print('clangd: didClose/didOpen renvoyés pour ce buffer.')
end, {})

