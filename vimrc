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
set spell spelllang=en_au          "spell checking support, with mutable dict
set showmode                       "on by default in vim, show the current mode
                                   ""in bottom menubar
let g:elite_mode=1                 "Disable arrows for remapping, use hjkl you
                                   ""lowtier pleb
" }}}

" Window movements {{{
if get(g:, 'elite_mode')
    nnoremap <Up>    <C-w>k
    nnoremap <Down>  <C-w>j
    nnoremap <Left>  <C-w>h
    nnoremap <Right> <C-w>l
endif
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
set ignorecase                               "search case insensitively
nnoremap <leader><space> :nohlsearch <CR>    "<,.> removes all hightlighting
" }}}

" Whitespace commands {{{
nnoremap <leader>w :%s/\s\+$//e <CR>    "<,w> removes all errant whitespace
" }}}

" Settings shortcuts {{{
nnoremap <leader>sp :set spell! <CR>    "<,sp> negates the current :spell setting
nnoremap <leader>p :set paste! <CR>     "<,p> negates the current paste setting
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
autocmd FileType python map <silent> <leader>bp oimport pdb; pdb.set_trace()<esc>
autocmd FileType python map <silent> <leader>BP Oimport pdb; pdb.set_trace()<esc>
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

" vim-terraform settings {{{
let g:terraform_align=1
let g:terraform_fold_sections=1
" }}}

" fzf settings {{{
nnoremap <C-s> :<C-u>FZF<CR>
" }}}

" vimwiki settings {{{
let g:vimwiki_use_calendar=1
let g:vimwiki_list = [{'path': '~/vimwiki/tech'},{'path': '~/vimwiki/personal'},{'path': "~/vimwiki/work"}]
" }}}

" easytags settings {{{
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1
" }}}

" tagbar settings {{{
nmap <silent> <leader>b :TagbarToggle<CR>
" }}}

" vim-test settings {{{
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
" }}}

" Nerdtree {{{
nnoremap <leader>n :NERDTreeToggle<CR>
" }}}

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

" IDE support
Plug 'deoplete-plugins/deoplete-jedi' " deoplete python support
Plug 'majutsushi/tagbar'           " a window for tags to be displayed
Plug 'xolox/vim-easytags'          " client interface for ctags binary
Plug 'xolox/vim-misc'              " provides req libs for easytags
Plug 'airblade/vim-gitgutter'      " provides a left side gutter of git actions
Plug 'davidhalter/jedi-vim'        " <Ctrl-Space> to enable autocomplete
Plug 'ervandew/supertab'           " use <Tab> to select autocomplete choices
Plug 'scrooloose/syntastic'        " syntax highlighting plugin interface
Plug 'vim-airline/vim-airline'     " bottom status barring, for a more ide feel
Plug 'ludovicchabant/vim-gutentags' " tag file management
Plug 'yggdroot/indentline'         " indentation indicator support
Plug 'sheerun/vim-polyglot'        " single plugin for syntax support
Plug 'janko/vim-test'              " test execution support
Plug 'Raimondi/delimitMate'        " auto delimiter completion
Plug 'scrooloose/nerdtree'

" code utility support
Plug 'tpope/vim-fugitive'          " Git wrapper for vim
Plug 'tpope/vim-commentary'        " easier commenting of code

" language support
Plug 'digitalrounin/vim-yaml-folds'  " Help with folding in YAML
Plug 'elzr/vim-json'               " Json helper
Plug 'heavenshell/vim-pydocstring' " provides auto docstring generation
Plug 'ntpeters/vim-better-whitespace' " Highlight and strip trailing whitespace
Plug 'nvie/vim-flake8'             " Perhaps redundant with python-mode included
Plug 'pearofducks/ansible-vim'     " Ansible Vim
Plug 'posva/vim-vue'               " syntax highlighting for vue
Plug 'johnvonneumann/vim-docstring-report' " find missing py docstrings
Plug 'vim-scripts/bash-support.vim'     " bash ide support
Plug 'aliou/bats.vim'               " syntax highlighting for bats-core

" vim utility support
Plug 'dense-analysis/ale'           " async linting with LangServProt support
Plug 'junegunn/fzf'                 " fuzzy file matching
Plug 'itchyny/calendar.vim'         " in vim calendar support with vimwiki integ
Plug 'tpope/vim-surround'           " binds for quoting words, `,\"${},\"`
Plug 'vimwiki/vimwiki'             " wiki system for note taking

call plug#end()
" }}}
