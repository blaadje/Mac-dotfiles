autocmd VimEnter * call timer_start(20, { tid -> execute(':silent exec "!kill -s SIGWINCH $PPID"')})


set encoding=UTF-8
set relativenumber
set termguicolors 
syntax on         
let mapleader = ","


lua <<EOF
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

vim.cmd('colorscheme base16-gruvbox-dark-soft')

-- Alternatively, you can provide a table specifying your colors to the setup function.
require('base16-colorscheme').setup({
    base00 = '#16161D', base01 = '#2c313c', base02 = '#3e4451', base03 = '#6c7891',
    base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
    base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
    base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
})

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF

let g:indentLine_char_list = ['|']
let g:indentLine_color_term = 239
let g:indentLine_bgcolor_term = 202
let g:indentLine_concealcursor = 'inc'
let g:indentLine_indentLevel = 2
let g:indentLine_leadingSpaceChar = '-'

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
                  
set background=dark
colorscheme material            
                  
nnoremap <leader>b :NERDTreeToggle<CR>                                                
                  
set wildignore+=*/node_modules/*,*/dist/*                                             
nnoremap <leader>p :CtrlP<CR>  



