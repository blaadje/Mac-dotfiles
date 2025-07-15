local themeColors = require('base16-colorscheme').colors

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

-- Incline configuration
require("incline").setup({
    render = function(props)
        if vim.bo.filetype == "NvimTree" then return {} end

        local mode = vim.fn.mode()
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

        return {
            {
                path,
                group = hl,
                clickable = true,
                on_click = function()
                    vim.fn.setreg('+', path)
                    vim.notify("Chemin copié dans le presse-papiers",
                               vim.log.levels.INFO)
                end
            }
        }
    end,
    window = {
        placement = {vertical = "bottom", horizontal = "right"},
        margin = {horizontal = 1, vertical = 0}
    }
})

-- Bufferline configuration
require("bufferline").setup {
    options = {
        mode = "buffers",
        indicator = {style = "none"},
        separator_style = "slant",
        disabled_filetypes = {'NvimTree'},
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                text_align = "left",
                separator = true
            }
        },
        style_preset = {
            require("bufferline").style_preset.no_italic,
            require("bufferline").style_preset.no_bold
        },
        -- padding = 10,
        custom_filter = function(buf_number, buf_numbers)
            local buf_name = vim.fn.bufname(buf_number)
            -- Exclure NERDTree
            if buf_name:match("NERD_tree_") then return false end
            return true
        end
    },
    highlights = {
        fill = {bg = themeColors.base00},
        background = {bg = themeColors.base00, fg = themeColors.base03},
        buffer_visible = {bg = themeColors.base00, fg = themeColors.base03},
        buffer = {bg = themeColors.base00, fg = themeColors.base03},
        buffer_selected = {
            bg = themeColors.base00,
            fg = themeColors.base05,
            bold = true
        },
        separator = {bg = themeColors.base00, fg = themeColors.base00},
        separator_visible = {bg = themeColors.base00, fg = themeColors.base00},
        separator_selected = {bg = themeColors.base00, fg = themeColors.base00},
        close_button = {fg = themeColors.base05, bg = themeColors.base00},
        tab = {bg = themeColors.base00},
        tab_selected = {bg = themeColors.base00},
        tab_separator = {bg = themeColors.base00, fg = themeColors.base00},
        tab_separator_selected = {
            bg = themeColors.base00,
            fg = themeColors.base00
        }
    }
}

require("dashboard").setup({
    theme = 'hyper',
    config = {
        week_header = {enable = true},
        shortcut = {
            {
                desc = '󰊳 Update',
                group = '@property',
                action = 'Lazy update',
                key = 'u'
            }, {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f'
            }, {
                desc = ' Apps',
                group = 'DiagnosticHint',
                action = 'Telescope app',
                key = 'a'
            }, {
                desc = ' dotfiles',
                group = 'Number',
                action = 'Telescope dotfiles',
                key = 'd'
            }
        }
    }
})

-- NvimTree configuration
require("nvim-tree").setup({
    update_focused_file = {enable = true, update_root = false, ignore_list = {}},
    view = {adaptive_size = false, centralize_selection = false, width = 50},
    renderer = {
        highlight_git = true,
        root_folder_label = false,
        indent_markers = {enable = false}
    },
    tab = {
        sync = {
            open = false, -- ⛔ ne pas ouvrir automatiquement le tree quand tu changes de tab
            close = false -- ⛔ ne pas fermer automatiquement
        }
    }
})

-- Trouble configuration
require("trouble").setup({
    position = "bottom",
    height = 80,
    width = 50,
    icons = true,
    mode = "workspace_diagnostics",
    severity = nil,
    fold_open = "",
    fold_closed = "",
    group = true,
    padding = true,
    cycle_results = true,
    action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = {"<cr>", "<tab>", "<2-leftmouse>"},
        open_split = {"<c-x>"},
        open_vsplit = {"<c-v>"},
        open_tab = {"<c-t>"},
        jump_close = {"o"},
        toggle_mode = "m",
        switch_severity = "s",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        open_code_href = "c",
        close_folds = {"zM", "zm"},
        open_folds = {"zR", "zr"},
        toggle_fold = {"zA", "za"},
        previous = "k",
        next = "j",
        help = "?"
    },
    multiline = false,
    indent_lines = true,
    win_config = {border = "single"},
    auto_open = false,
    auto_close = false,
    auto_preview = true,
    auto_fold = false,
    auto_jump = {"lsp_definitions"},
    include_declaration = {
        "lsp_references", "lsp_implementations", "lsp_definitions"
    },
    signs = {error = "", warning = "", hint = "", information = "", other = ""},
    use_diagnostic_signs = false
})

-- Indent blankline configuration
local colors = require('highlights')

require("ibl").setup {
    enabled = true,
    indent = {
        char = " " -- Use space character (invisible)
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        char = "┃", -- Visible character for scope
        highlight = colors.highlight
    }
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.SCOPE_HIGHLIGHT,
               hooks.builtin.scope_highlight_from_extmark)
