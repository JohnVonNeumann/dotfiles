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
Plug 'klen/python-mode'                      " All encompassing Py Dev Package
Plug 'leafgarland/typescript-vim'            " Angular syntax highlighting
call plug#end()
" }}}

" PyMode Specific Settings {{{
" Change guide reference: 
" https://github.com/python-mode/python-mode/blob/develop/doc/pymode.txt
let g:pymode_folding = 0                     " disable pymode code folding disabled

let g:pymode_doc = 1                         " enable pymode_docs plugin
let g:pymode_doc_bind ='K'                   " bind to K from command mode

let g:pymode_run = 1                         " enable pymode_run plugin, allows code runs from vim
let g:pymode_run_bind = '<leader>r'          " bind to ,r from command mode

let g:pymode_breakpoint = 1                  " enable python breakpoint plugin, allows pdb breakpoints to be set
let g:pymode_breakpoint_bind = '<leader>b'   " bind to ,b from command mode

let g:pymode_lint = 1                        " enable pymode lint plugin
let g:pymode_lint_on_fly = 1 
let g:pymode_lint_checkers = ['mccabe', 'pep8', 'pep257', 'pyflakes']
let g:pymode_lint_options_mccabe = { 'complexity': 3 }
let g:pymode_lint_select ="E,W,C"

let g:pymode_syntax = 1                      " enable pymode syntax highlighting

let g:pymode_rope_completion = 1             " enable pymode rope syntax autocompletion
let g:pymode_rope_complete_on_dot = 1        " enable . function autocomplete for libraries

let g:pymode_indent = 1                      " think I have this sorted, will experiment
let g:pymode_python = 'python3'              " pymode defaults to python2 syntax checking
let g:pymode_options_max_line_length = 79    " fix max line length to pep8 standard
let g:pymode_options_colorcolumn = 1         " create red border at 79 chars

" }}}
