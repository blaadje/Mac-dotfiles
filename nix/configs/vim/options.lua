-- Options de base
vim.opt.laststatus = 0
vim.opt.statuscolumn = "%s%l   "
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.winbar = " "

-- Leader key
vim.keymap.set("n", " ", "<Nop>", {silent = true, remap = false})
vim.g.mapleader = " "

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
    underline = true,
    signs = true
})

-- LSP handlers
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
