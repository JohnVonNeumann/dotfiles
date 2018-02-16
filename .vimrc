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
set smartindent                              "autoindent to last level of code
" }}}

" Ansible-Vim settings {{{
let g:ansible_unindent_after_newline = 1     "unindents to base left marg on double enter
" }}}

" Vim-Airline settings {{{
" will make some edits to this as I play with it
" }}}

" indentline settings {{{
" will make some edits to this as I play with it
" }}}

" Vim Plug {{{
call plug#begin('~/.vim/plugged')
Plug 'nvie/vim-flake8'                       " Perhaps redundant with python-mode included
Plug 'yggdroot/indentline'                   " indentation indicator support
Plug 'vim-airline/vim-airline'               " bottom status barring, for a more ide feel
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'
    " <Ctrl-Space> to enable autocomplete
Plug 'tpope/vim-fugitive' " Git wrapper for vim
Plug 'pearofducks/ansible-vim'   " Ansible Vim
call plug#end()
" }}}

