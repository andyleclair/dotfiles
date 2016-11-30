" .vimrc
" by Andy LeClair
" andyleclair@gmail.com

" We're VIMproved!
set nocompatible

filetype off


"""""""""""""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""""""""""""

" Setup Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/vundle'

" Plugin these plugins
Plugin 'tsaleh/vim-align'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'thoughtbot/vim-rspec'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'briancollins/vim-jst'
Plugin 'Shougo/deoplete.nvim'
Plugin 'sunaku/vim-ruby-minitest'
Plugin 'mtth/scratch.vim'
Plugin 'wlangstroth/vim-racket'
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'bling/vim-airline'
Plugin 'ntpeters/vim-better-whitespace'

""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""

" Install Solarized (the last color scheme you'll ever need)
Plugin 'altercation/vim-colors-solarized'
call vundle#end()

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


""""""""""""""""""""""""""""""""""""""
" Key Bindings
""""""""""""""""""""""""""""""""""""""
" Map return in command mode to clear search buffer
nnoremap <cr> :noh<cr><cr>

" Map leader to \ because I like that instead of ,
let mapleader="\\"

" File navigation with ease

" Ctrl-p mapped to <leader>f
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
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ deoplete#mappings#manual_complete()

set clipboard=unnamedplus
