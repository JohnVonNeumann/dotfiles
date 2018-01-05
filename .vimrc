" UI Config {{{
set number                                   "show line numbers
set showcmd                                  "show command in bottom bar
set cursorline                               "highlight current line
set wildmenu                                 "visual autocomplete for command menu
set showmatch                                "highlight matching parentheses
" }}}

" Search {{{
set incsearch                                "search as chars are entered
set hlsearch                                 "highlight search matches
let mapleader=","                           
nnoremap <leader><space> :nohlsearch <CR>
" }}} 

" Spaces V Tabs {{{
set tabstop=4                                "4 space tab
set expandtab                                "use spaces for tabs
set softtabstop=4                            "number of spaces in tab when editing
" }}}

" Vim Plug {{{
call plug#begin('~/.vim/plugged')
Plug 'nvie/vim-flake8'                       " Perhaps redundant with python-mode included
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'
    " <Ctrl-Space> to enable autocomplete
call plug#end()
" }}}

