local themeColors = require('base16-colorscheme').colors

-- First incline bar - File path + diagnostics (bottom right)
local incline1 = require("incline")
local util1 = require('incline.util')
local manager1 = require('incline.manager')

incline1.setup({
    render = function(props)
        if vim.bo.filetype == "NvimTree" then return {} end

        -- Defer mode check to avoid race conditions
        local mode = vim.schedule_wrap(function() return vim.fn.mode() end)() or
                         vim.fn.mode()
        local hl_map = {
            n = "InclineNormal",
            i = "InclineInsert",
            v = "InclineVisual",
            V = "InclineVisual",
            ["\22"] = "InclineVisual",
            c = "InclineCommand",
            s = "InclineVisual",
            R = "InclineReplace"
        }
        local hl = hl_map[mode] or "InclineNormal"

        local path = vim.fn.expand("%:.")
        local max_path_len = 60 -- Limiter à 40 caractères

        if #path > max_path_len then
            local filename = vim.fn.expand("%:t") -- Nom du fichier seul
            local remaining_len = max_path_len - #filename - 4 -- -4 pour ".../"
            if remaining_len > 0 then
                local dir_part = string.sub(path, 1, remaining_len)
                path = dir_part .. ".../" .. filename
            else
                path = ".../" .. filename
            end
        end

        local modified_indicator = vim.bo.modified and " ●" or ""

        return {
            {
                " " .. path .. modified_indicator .. " ",
                group = hl,
                clickable = true,
                on_click = function()
                    vim.fn.setreg('+', vim.fn.expand("%:.")) -- Copier le chemin complet
                    vim.notify("Chemin copié dans le presse-papiers",
                               vim.log.levels.INFO)
                end
            }
        }
    end,

    window = {
        placement = {vertical = "bottom", horizontal = "left"},
        margin = {horizontal = 1, vertical = 0},
        padding = 0
    }
})

util1.clear_augroup()
vim.api.nvim_create_autocmd({
    'BufEnter', 'WinEnter', 'FocusGained', 'VimResized', 'BufModifiedSet'
}, {callback = function() manager1.update {refresh = true} end})

-- Separate autocmd for mode changes with delay
vim.api.nvim_create_autocmd({'ModeChanged'}, {
    callback = function()
        vim.defer_fn(function() manager1.update {refresh = true} end, 50)
    end
})

-- Second incline bar - Git branch (top left)
-- Clear incline modules to allow second instance
package.loaded['incline'] = false
package.loaded['incline.config'] = false
package.loaded['incline.debounce'] = false
package.loaded['incline.highlight'] = false
package.loaded['incline.manager'] = false
package.loaded['incline.tabpage'] = false
package.loaded['incline.util'] = false
package.loaded['incline.winline'] = false

local incline = require("incline")
local util = require('incline.util')
local manager = require('incline.manager')

incline.setup({
    render = function(props)
        if vim.bo.filetype == "NvimTree" then return {} end
        if not props.focused then return {} end

        local bufnr = props.buf
        local diagnostics = vim.diagnostic.count(bufnr)

        local icons = {
            Error = {icon = "", color = "#F7768E"},
            Warn = {icon = "", color = "#E0AF68"},
            Info = {icon = "", color = "#7AA2F7"},
            Hint = {icon = "󰌵", color = "#73DACA"}
        }

        local diag_parts = {}
        for severity, data in pairs(icons) do
            local key = vim.diagnostic.severity[string.upper(severity)]
            local count = diagnostics[key] or 0
            if count > 0 then
                table.insert(diag_parts, {
                    "  " .. data.icon .. " " .. count .. "  ",
                    guifg = data.color,
                    guibg = "NONE"
                })
            end
        end

        if #diag_parts == 0 then return {} end

        return diag_parts
    end,

    window = {
        placement = {vertical = "top", horizontal = "right"},
        margin = {horizontal = 1, vertical = 0},
        padding = 0
    }
})

-- Update second incline when needed
util.clear_augroup()
vim.api.nvim_create_autocmd({
    'BufEnter', 'WinEnter', 'FocusGained', 'DiagnosticChanged', 'VimResized'
}, {callback = function() manager.update {refresh = true} end})
