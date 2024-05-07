local opts = {noremap = true, silent = true}

vim.api.nvim_set_keymap("i", "nn", "<Esc>", {noremap = true})

vim.api.nvim_set_keymap("n", "<C-Tab>", ":tabnext<CR>",
                        {noremap = true, silent = true})

vim.keymap.set('n', '<C-p>', function()
    require('telescope').extensions['recent-files'].recent_files({})
end, {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>",
                        {noremap = true, silent = true})
vim.keymap.set('n', '<A-Down>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-Up>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<C-b>', ':NERDTreeToggle<CR>', opts)
