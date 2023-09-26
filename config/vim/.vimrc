"""""""""""""""
"" VIM SETTINGS
"""""""""""""""

syntax on
filetype plugin indent on
scriptencoding utf-8

"Move over end of line
set whichwrap=b,s,<,>,[,],h,l
" Backspace over autoindent, line breaks, start of insert (see :help 'backspace')
set backspace=indent,eol,start
"Auto indentation
set autoindent
"Tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab

" Paste mode toggle key
set pastetoggle=<F11>

" Set Leader Key
let g:mapleader = "\<space>"
let g:localmapleader = "\<space>"

"" Mouse Settings
if has('mouse')
    set mouse=a
    set selectmode=mouse
endif

"" Search Settings
"Better Tab Completion
set wildmenu
set wildmode=list:longest
set hlsearch
set ignorecase
set smartcase
set incsearch

"" Misc Settings
" Status Line
set laststatus=3
"Bigger History
set history=1000
" keep at least 5 lines above/below
set scrolloff=8
set sidescrolloff=8
"1000 Undos
set undolevels=1000
"Dont move to startofline
set nostartofline
"Activate hidden buffers
set hidden
"Automatically read buffer when changed outside of vim
set autoread
"Place backup and temp directory somewhere else
set backup
"Use "./" in the 'tags' options reads tags file relative to current directory
set cpoptions+=d
" Backup, tag and undo locations
set backupdir=~/.local/share/vim/backup
set directory=~/.local/share/vim/tmp
set undodir=~/.local/share/vim/undo
" Line numbers
set number
" Make bell visual and disable error bells
set visualbell
set noerrorbells
" Show (partial) command in status line
set showcmd
" Colorize column 80
set colorcolumn=80
"
" Enable persistent undo
if has("persistent_undo")
    set undofile
endif

set ttyfast



""""""""""""""
"" KEYBINDINGS
""""""""""""""

nnoremap <C-s> :write<cr>

nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprev<cr>

nnoremap <leader>wc <C-W>c
nnoremap <leader>ws <C-W>s
nnoremap <leader>wv <C-W>v
nnoremap <leader>ww <C-W>w

nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
