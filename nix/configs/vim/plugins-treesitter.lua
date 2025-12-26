-- Treesitter configuration
require("nvim-treesitter.configs").setup {
    autotag = {enable = true},
    highlight = {enable = true}
}

-- Tree-sitter language injection setup
require("tree-sitter-language-injection").setup({
    cpp = {
        string = {
            langs = {{name = "html", match = "<"}, {name = "css", match = "/\\*"}},
            query = [[
        ; raw string
        ((raw_string_content) @injection.content
         (#match? @injection.content "{match}")
         (#set! injection.language "{name}"))
      ]]
        }
    }
})
-- Rainbow delimiters configuration
local rainbow_delimiters = require "rainbow-delimiters"
local colors = require('highlights')

vim.g.rainbow_delimiters = {
    strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        commonlisp = rainbow_delimiters.strategy["local"]
    },
    query = {
        vue = "rainbow-parens",
        html = "rainbow-parens",
        jsx = "rainbow-parens",
        tsx = "rainbow-parens",
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks"
    },
    priority = {[""] = 110, lua = 210},
    blacklist = {"c", "cpp", "html"},
    highlight = colors.highlight
}
