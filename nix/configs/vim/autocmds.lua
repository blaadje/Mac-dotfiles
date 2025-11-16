vim.g.neoformat_enabled_cpp = {'clangformat', 'prettier'}
vim.g.neoformat_enabled_c = {'clangformat'}

vim.g.neoformat_cpp_clangformat = {
    exe = '/mnt/c/Users/aukx/.config/mingw64/bin/clang-format.exe',
    args = {'--style=file'},
    stdin = 1,
    stderr = 1
}
vim.g.neoformat_c_clangformat = vim.g.neoformat_cpp_clangformat

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
        "*.lua", "*.nix", "*.go", "*.json", "*.js", "*.ts", "*.tsx", "*.jsx",
        "*.css", "*.html", "*.md", "*.yaml", "*.yml", "*.hbs", "*.c", "*.cpp",
        "*.h", "*.hpp"
    },
    command = "Neoformat"
})

vim.g.neoformat_enabled_hbs = {"prettierd"}
vim.g.neoformat_hbs_prettierd = {
    exe = "prettierd",
    args = {"%:p"},
    stdin = 1,
    cwd = "%:p:h"
}

