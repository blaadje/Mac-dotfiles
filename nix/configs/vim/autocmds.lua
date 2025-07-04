-- Autocommands pour le formatage automatique
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
        "*.lua", "*.nix", "*.go", "*.json", "*.js", "*.ts", "*.tsx", "*.jsx",
        "*.css", "*.html", "*.md", "*.yaml", "*.yml", "*.hbs"
    },
    command = "Neoformat"
})

-- Configuration pour le formatage HBS
vim.g.neoformat_enabled_hbs = {"prettierd"}
vim.g.neoformat_hbs_prettierd = {
    exe = "prettierd",
    args = {"%:p"},
    stdin = 1,
    cwd = "%:p:h"
}