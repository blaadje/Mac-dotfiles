lua <<EOF
require("indent_blankline").setup {
  space_char_blankline = " | ",
  indent_blankline_enabled = 1,
  show_current_context = true,
}
EOF


set encoding=UTF-8
set relativenumber
set termguicolors
syntax on
let mapleader = ","



let g:material_style='palenight'

set background=dark
colorscheme material

nnoremap <leader>b :NERDTreeToggle<CR>

set wildignore+=*/node_modules/*,*/dist/*
nnoremap <leader>p :CtrlP<CR>

