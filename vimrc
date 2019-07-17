" General Settings {{{
set title
" set the title
set titlestring=%{substitute(getcwd(),\ $HOME,\ '~',\ '')}/
set titlestring+=%f
set nocompatible
set guicursor=
set backspace=indent,eol,start     "had a situation where my vim backspace broke
                                   ""so this is the solution
set filetype=on                    "enable filetype detection for autocmd
set hidden                         ""hide unsaved buffers instead of
                                   ""closing them, so we can do
                                   "":argdo without pain
let mapleader=","                  "changes the default leader key from / to ,
                                   "so commands can be run with ,{key}
" }}}

" Folding {{{
set foldmethod=marker                 "will fold vimrc by markers, only vimfiles
highlight Folded ctermfg=Black        "set fold's text to black
highlight Folded ctermbg=Magenta      "set fold's background to magenta
" }}}

"UI Config {{{
set number                           "show line numbers
set colorcolumn=81                   "sets a column at 80 chars
highlight ColorColumn ctermbg=1*     "sets column colour to red
set showcmd                          "show command in bottom bar
set cursorline                       "highlight current line
set wildmenu                         "visual autocomplete for command menu
set showmatch                        "highlight matching parentheses
set t_Co=256
" }}}

" Search {{{
set incsearch                                "search as chars are entered
set hlsearch                                 "highlight search matches
nnoremap <leader><space> :nohlsearch <CR>    "<,.> removes all hightlighting
" }}}

" Whitespace commands {{{
nnoremap <leader>w :%s/\s\+$//e <CR>    "<,w> removes all errant whitespace
" }}}

" Spaces V Tabs {{{
set tabstop=4                   "4 space tab
set expandtab                   "use spaces for tabs
set softtabstop=4               "number of spaces in tab when editing
set smartindent                 "autoindent to last level of code
" }}}

" {{{ json specific settings
autocmd FileType json setlocal shiftwidth=2 tabstop=2
" }}}

" {{{ yaml specific settings
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
" }}}

" {{{ python specific settings
autocmd FileType python map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
autocmd FileType python map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>
" }}}

" {{{ c specific settings
autocmd FileType c setlocal shiftwidth=4 tabstop=4
" }}}

" Ansible-Vim settings {{{
let g:ansible_unindent_after_newline = 1    "indent as new node on double enter
" }}}

" Deoplete settings {{{
let g:deoplete#enable_at_startup = 1
" }}}

" Vim-Airline settings {{{
" will make some edits to this as I play with it
" }}}

" indentline settings {{{
" will make some edits to this as I play with it
" }}}

" syntastic settings {{{

" These settings aren't by me, they're the recommended settings
" https://github.com/vim-syntastic/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" }}}

" vim-terraform settings
let g:terraform_align=1
let g:terraform_fold_sections=1

" Vim Plug {{{
call plug#begin('~/.vim/autoload')
if has('nvim')
  " auto suggestion for python
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'airblade/vim-gitgutter'      " provides a left side gutter of git actions
Plug 'bbatsov/rubocop'
Plug 'cocopon/iceberg.vim'
Plug 'davidhalter/jedi-vim'        " <Ctrl-Space> to enable autocomplete
Plug 'digitalrounin/vim-yaml-folds'  " Help with folding in YAML
Plug 'elzr/vim-json'               " Json helper
Plug 'ervandew/supertab'           " use <Tab> to select autocomplete choices
Plug 'hashivim/vim-hashicorp-tools'
Plug 'hashivim/vim-terraform'      " terraform support
Plug 'hashivim/vim-vaultproject'
Plug 'heavenshell/vim-pydocstring' " provides auto docstring generation
Plug 'juliosueiras/vim-terraform-completion'
Plug 'martinda/jenkinsfile-vim-syntax'
Plug 'ngmy/vim-rubocop'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvie/vim-flake8'             " Perhaps redundant with python-mode included
Plug 'pearofducks/ansible-vim'     " Ansible Vim
Plug 'posva/vim-vue'               " syntax highlighting for vue
Plug 'scrooloose/syntastic'        " syntax highlighting plugin interface
Plug 'tpope/vim-fugitive'          " Git wrapper for vim
Plug 'vim-airline/vim-airline'     " bottom status barring, for a more ide feel
Plug 'yggdroot/indentline'         " indentation indicator support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-scripts/c.vim'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vimwiki/vimwiki'
Plug 'pangloss/vim-javascript'
Plug 'johnvonneumann/vim-docstring-report'
Plug 'hashicorp/sentinel.vim'
Plug 'hashivim/vim-packer'
Plug 'vim-scripts/bash-support.vim'     " bash ide support
call plug#end()
" }}}

