local hooks = require "ibl.hooks"
local themeColors = require('base16-colorscheme').colors

local colors = {
    error = "#f24b42",
    warning = "#e0af68",
    info = "#0db9d7",
    hint = "#10b981",
    highlight = {
        "RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange",
        "RainbowGreen", "RainbowViolet", "RainbowCyan"
    }
}

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", {fg = "#E06C75"})
    vim.api.nvim_set_hl(0, "RainbowYellow", {fg = "#E5C07B"})
    vim.api.nvim_set_hl(0, "RainbowBlue", {fg = "#61AFEF"})
    vim.api.nvim_set_hl(0, "RainbowOrange", {fg = "#D19A66"})
    vim.api.nvim_set_hl(0, "RainbowGreen", {fg = "#98C379"})
    vim.api.nvim_set_hl(0, "RainbowViolet", {fg = "#C678DD"})
    vim.api.nvim_set_hl(0, "RainbowCyan", {fg = "#56B6C2"})
end)

vim.api.nvim_set_hl(0, "DiagnosticError", {fg = colors.error})
vim.api.nvim_set_hl(0, "DiagnosticWarn", {fg = colors.warning})
vim.api.nvim_set_hl(0, "DiagnosticInfo", {fg = colors.info})
vim.api.nvim_set_hl(0, "DiagnosticHInt", {fg = colors.hint})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {fg = colors.error})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {fg = colors.warning})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {fg = colors.info})
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHInt", {fg = colors.hint})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError",
                    {undercurl = true, sp = colors.error})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",
                    {undercurl = true, sp = colors.warning})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",
                    {undercurl = true, sp = colors.info})
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",
                    {undercurl = true, sp = colors.hint})

vim.api.nvim_set_hl(0, "VertSplit", {fg = themeColors.base01})
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", {fg = themeColors.base01})
return colors
