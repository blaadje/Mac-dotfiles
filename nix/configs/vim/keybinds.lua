-- keymaps.lua
local M = {}

-- Fonction utilitaire pour les keybindings
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end

    if type(rhs) == "string" then
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    elseif type(rhs) == "function" then
        vim.keymap.set(mode, lhs, rhs, options)
    end
end

-- Table de keybindings
local keybinds = {
    -- Mode normal
    n = {
        ["<C-Tab>"] = ":tabnext<CR>",
        ["<C-S-Tab>"] = ":tabprev<CR>",
        ["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
        ["gD"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
        ["<A-Down>"] = ":MoveLine(1)<CR>",
        ["<A-Up>"] = ":MoveLine(-1)<CR>",
        ["<C-b>"] = ":NvimTreeToggle<CR>",
        ["<C-p>"] = function()
            require('telescope').extensions['recent-files'].recent_files({})
        end,
        ["<C-e>"] = function() require('trouble').toggle() end,
        ["<C-w>"] = function() vim.lsp.buf.hover() end,
        ["<leader>ff"] = function()
            require('telescope.builtin').find_files()
        end,
        ["<leader>fg"] = function()
            require('telescope.builtin').live_grep()
        end,
        ["<leader>fb"] = function()
            require('telescope.builtin').buffers()
        end,
        ["<leader>fh"] = function()
            require('telescope.builtin').help_tags()
        end
    },
    -- Mode insertion
    i = {["hh"] = "<Esc>"},
    -- Mode visuel
    v = {["<C-c>"] = '"+y'}
}

-- Fonction pour appliquer les keybindings
function M.setup()
    for mode, mappings in pairs(keybinds) do
        for lhs, rhs in pairs(mappings) do map(mode, lhs, rhs) end
    end
end

M.setup()

