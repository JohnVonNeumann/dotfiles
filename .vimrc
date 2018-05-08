" General Settings {{{
set filetype=on
set hidden                                   "hide unsaved buffers instead of 
                                             "closing them, so we can do
                                             ":argdo without pain
let mapleader=","                            "changes the default leader key from / to ,
                                             "so commands can be run with ,{key}
" }}}

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
nnoremap <leader><space> :nohlsearch <CR>
                                             "<,.> removes all hightlighting 
" }}} 

" Spaces V Tabs {{{
set tabstop=4                                "4 space tab
set expandtab                                "use spaces for tabs
set softtabstop=4                            "number of spaces in tab when editing
set smartindent                              "autoindent to last level of code
" }}}

" {{{ json specific settings
autocmd FileType json setlocal shiftwidth=2 tabstop=2
" }}}

" {{{ python specific settings
autocmd FileType python map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
autocmd FileType python map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>
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
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif
let g:deoplete#enable_at_startup = 1
Plug 'nvie/vim-flake8'                       " Perhaps redundant with python-mode included
Plug 'yggdroot/indentline'                   " indentation indicator support
Plug 'vim-airline/vim-airline'               " bottom status barring, for a more ide feel
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'
    " <Ctrl-Space> to enable autocomplete
Plug 'tpope/vim-fugitive'                    " Git wrapper for vim
Plug 'pearofducks/ansible-vim'               " Ansible Vim
Plug 'posva/vim-vue'                         " syntax highlighting for vue
Plug 'elzr/vim-json'                         " Json helper
call plug#end()
" }}}

