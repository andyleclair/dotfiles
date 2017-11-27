" .vimrc
" by Andy LeClair
" andyleclair@gmail.com

" We're VIMproved!
set nocompatible

filetype off


"""""""""""""""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""""""""""""""

" Setup vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Plug these plugins
Plug 'tsaleh/vim-align'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'scrooloose/nerdtree'
"Plug 'Shougo/deoplete.nvim'
Plug 'sunaku/vim-ruby-minitest'
Plug 'kien/rainbow_parentheses.vim'
Plug 'bling/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'

""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""

" Install Solarized (the last color scheme you'll ever need)
Plug 'altercation/vim-colors-solarized'

call plug#end()

filetype plugin indent on

syntax enable
set background=dark
colorscheme solarized

" Disable the GUI menu bar (if running)
if has("gui_running")
  set guioptions-=T
endif

"
" Tabs n' shit
"
" Tabs / Spaces
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set smartindent

" Line Nunbers
set number

" Incremental search, highlight searches
set incsearch
set hlsearch

" Make sure airline always shows up
set laststatus=2

set shell=zsh

" Enable mouse, because sometimes someone else might use my machine
set mouse=a

" Set per-filetype preferences
autocmd FileType javascript setlocal ts=4 sw=4 sts=4


""""""""""""""""""""""""""""""""""""""
" Key Bindings
""""""""""""""""""""""""""""""""""""""
" Map return in command mode to clear search buffer
nnoremap <cr> :noh<cr><cr>

" Map leader to \ because I like that instead of ,
let mapleader="\\"

" File navigation with ease

" Map ctrlp to \f
map <leader>f :CtrlPMixed<cr>

" Edit in current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" Tab navigation
noremap <c-tab> :tabnext<cr>

" NerdTree
map <leader>n :NERDTreeToggle<cr>

" Split/vsplit
map <leader>s :split<cr>
map <leader>v :vsplit<cr>

" Scratch buffer
map <leader>r :Scratch<cr>

" Turn off the arrow keys you fucking Neanderthal. THIS IS VIM!
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"""""""""""""""""""""""""""""""""""""""
" Swap file containment
"""""""""""""""""""""""""""""""""""""""

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

""""""""""""""""""""""""""""""""""""""
" Miscellaneous Config
""""""""""""""""""""""""""""""""""""""

" NerdTree should show hidden files
let NERDTreeShowHidden=1

" Set .hamlc to be read as .haml
au BufRead,BufNewFile *.hamlc set ft=haml

" Clear trailing whitespace on file save
autocmd BufWritePre * StripWhitespace

" deoplete config
"let g:deoplete#enable_at_startup = 1
"inoremap <silent><expr> <Tab>
"      \ pumvisible() ? "\<C-n>" :
"      \ deoplete#mappings#manual_complete()

set clipboard=unnamedplus
