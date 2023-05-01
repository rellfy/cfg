call plug#begin()
Plug 'sainnhe/sonokai'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
" Use Tab for trigger completion and navigate completion items
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ <SID>check_back_space() ? '<Tab>' :
      \ coc#refresh()
