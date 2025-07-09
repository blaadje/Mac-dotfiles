-- Plugins de base simples
require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>'
})
require("nvim-autopairs").setup()
require('Comment').setup()
require('move').setup()
require("yanky").setup()
require('colorizer').setup()
