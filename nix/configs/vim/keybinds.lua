local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",
                        opts)
vim.api.nvim_set_keymap("i", "hh", "<Esc>", opts)
vim.api.nvim_set_keymap("n", "<C-Tab>", ":tabnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-S-Tab>", ":tabprev<CR>", opts)
vim.api
    .nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

vim.keymap.set('n', '<A-Down>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-Up>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', opts)
vim.keymap.set({'n'}, '<C-w>', function() vim.lsp.buf.hover() end, opts)
vim.keymap.set('n', '<C-p>', function()
    require('telescope').extensions['recent-files'].recent_files({})
end, opts)
vim.keymap.set("n", "<C-e>", function() require("trouble").toggle() end)

