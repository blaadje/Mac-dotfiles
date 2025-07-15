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

vim.api.nvim_set_hl(0, "BufferlineOffsetSeparator", {
    fg = themeColors.base02, -- ligne verticale (couleur du trait)
    bg = themeColors.base00 -- fond homogène avec le reste
})

-- Incline highlights
vim.api.nvim_set_hl(0, "InclineNormal",
                    {fg = "#ffffff", bg = themeColors.base00, bold = true})
vim.api.nvim_set_hl(0, "InclineInsert",
                    {fg = "#000000", bg = "#fdd835", bold = true})
vim.api.nvim_set_hl(0, "InclineVisual",
                    {fg = "#ffffff", bg = "#43a047", bold = true})
vim.api.nvim_set_hl(0, "InclineCommand",
                    {fg = "#ffffff", bg = "#1976d2", bold = true})
vim.api.nvim_set_hl(0, "InclineReplace",
                    {fg = "#ffffff", bg = "#e53935", bold = true})

-- Telescope highlights
vim.api.nvim_set_hl(0, "TelescopeBorder", {fg = themeColors.base02})
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {bg = themeColors.base00})

-- Diagnostic highlights
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

-- Window separators
vim.api.nvim_set_hl(0, "VertSplit",
                    {fg = themeColors.base02, bg = themeColors.base00})
vim.api.nvim_set_hl(0, "WinSeparator",
                    {fg = themeColors.base02, bg = themeColors.base00})
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", {fg = themeColors.base02})

-- NvimTree file highlights
vim.api.nvim_set_hl(0, "NvimTreeNormal", {fg = themeColors.base03})
vim.api.nvim_set_hl(0, "NvimTreeCursorLine", {fg = themeColors.base05, bg = themeColors.base02})
vim.api.nvim_set_hl(0, "NvimTreeFocusedFile", {fg = themeColors.base05, bold = true})

-- Search and UI elements
vim.api.nvim_set_hl(0, 'Search',
                    {fg = themeColors.base08, bg = themeColors.base04})
vim.api.nvim_set_hl(0, 'CursorLine', {bg = themeColors.base02})
vim.api.nvim_set_hl(0, "Background", {fg = "NONE"})
vim.api.nvim_set_hl(0, "LineNr", {fg = themeColors.base02})

return colors
