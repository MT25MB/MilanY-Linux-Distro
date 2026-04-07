" milanY vim configuration
" personalized for "Down with Big Brother" channel

" basic settings
set number
set relativenumber
set ruler
set wrap
set showcmd
set wildmenu
set nohlsearch
set incsearch
set smartcase
set ignorecase
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set cindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set mouse=a
set encoding=utf8
set fileencoding=utf8

" security settings
set nobackup
set noswapfile
set noundofile
set viminfo=
set history=50

" colors - personalized theme
set background=dark
colorscheme default
hi Normal ctermfg=15 ctermbg=0
hi LineNr ctermfg=8 ctermbg=0
hi CursorLine ctermbg=8
hi CursorLineNr ctermfg=15 ctermbg=8
hi Visual ctermbg=13
hi Search ctermfg=0 ctermbg=13
hi IncSearch ctermfg=0 ctermbg=13
hi Comment ctermfg=8
hi String ctermfg=13
hi Number ctermfg=6
hi Boolean ctermfg=6
hi Function ctermfg=9
hi Keyword ctermfg=5
hi Type ctermfg=12
hi Special ctermfg=11
hi Error ctermfg=1 ctermbg=0
hi Warning ctermfg=11 ctermbg=0
hi StatusLine ctermfg=15 ctermbg=8
hi StatusLineNC ctermfg=8 ctermbg=0

" file types
autocmd BufRead,BufNewFile *.py set syntax=python
autocmd BufRead,BufNewFile *.sh set syntax=bash
autocmd BufRead,BufNewFile *.js set syntax=javascript
autocmd BufRead,BufNewFile *.html set syntax=html
autocmd BufRead,BufNewFile *.css set syntax=css
autocmd BufRead,BufNewFile *.json set syntax=json
autocmd BufRead,BufNewFile *.xml set syntax=xml
autocmd BufRead,BufNewFile *.yaml set syntax=yaml
autocmd BufRead,BufNewFile *.yml set syntax=yaml
autocmd BufRead,BufNewFile *.md set syntax=markdown

" security file types
autocmd BufRead,BufNewFile *.key set syntax=none
autocmd BufRead,BufNewFile *.pem set syntax=none
autocmd BufRead,BufNewFile *.crt set syntax=none
autocmd BufRead,BufNewFile *password* set syntax=none

" status line
set laststatus=2
set statusline=%f
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=%=
set statusline+=%y
set statusline+=\ %l/%L
set statusline+=\ %c
set statusline+=\ %P

" key bindings
let mapleader = ","
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>e :e<SPACE>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>1 :1gt<CR>
nnoremap <leader>2 :2gt<CR>
nnoremap <leader>3 :3gt<CR>
nnoremap <leader>4 :4gt<CR>
nnoremap <leader>5 :5gt<CR>
nnoremap <leader>6 :6gt<CR>
nnoremap <leader>7 :7gt<CR>
nnoremap <leader>8 :8gt<CR>
nnoremap <leader>9 :9gt<CR>
nnoremap <leader>0 :10gt<CR>

" search
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" navigation
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
nnoremap H ^
nnoremap L $

" split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" plugins (if installed)
if filereadable('/usr/share/vim/vimfiles/plugin/plug.vim')
    call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'majutsushi/tagbar'
    call plug#end()
endif

" startup message
if !argc()
    echo "milany vim - secure editor ready"
endif
