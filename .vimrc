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
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Bundle these plugins
Bundle 'tsaleh/vim-align'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-rails'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'kchmck/vim-coffee-script'
Bundle 'skwp/vim-rspec'
Bundle 'pangloss/vim-javascript'
Bundle 'briancollins/vim-jst'
Bundle 'Valloric/YouCompleteMe'

""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""

" Install Solarized (the last color scheme you'll ever need)
Bundle 'altercation/vim-colors-solarized'

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
