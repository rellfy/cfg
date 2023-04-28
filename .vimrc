call plug#begin()
Plug 'sainnhe/sonokai'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
call plug#end()
let g:sonokai_style = 'espresso'
color sonokai
set termguicolors
set nospell
set number
set cursorline
set shiftwidth=4
set smarttab
syntax enable
filetype plugin indent on
