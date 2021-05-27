" .vimrc
" by Andy LeClair
" andyleclair@gmail.com

" We're VIMproved!
set nocompatible

filetype off

" Needs to be before ALE is loaded
let g:ale_completion_enabled = 1

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
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'Shougo/deoplete.nvim'
Plug 'sunaku/vim-ruby-minitest'
Plug 'kien/rainbow_parentheses.vim'
Plug 'bling/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-mix-format'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-startify'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'dense-analysis/ale'

""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""

" Install Solarized (the last color scheme you'll ever need)
Plug 'iCyMind/NeoSolarized'
Plug 'cocopon/iceberg.vim'
" Very important, needs to be last
Plug 'ryanoasis/vim-devicons'
call plug#end()

filetype plugin indent on

syntax enable
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
"set background=dark
colorscheme iceberg

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
"
set number

" Incremental search, highlight searches
set incsearch
set hlsearch

" Make sure airline always shows up
set laststatus=2

set shell=zsh

" Enable mouse, because sometimes someone else might use my machine
set mouse=a

"""
" ALE Settings
"""

let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls']

" Required, tell ALE where to find Elixir LS
let g:ale_elixir_elixir_ls_release = expand("~/elixir-ls/rel")

" Optional, you can disable Dialyzer with this setting
let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:false}}

" Optional, configure as-you-type completions
set completeopt=menu,menuone,preview,noselect,noinsert
let g:airline#extensions#ale#enabled = 1

" Format my cod3
let g:ale_fixers = {}
let g:ale_fixers.elixir = [ 'mix_format' ]

autocmd FileType elixir,eelixir nnoremap <Leader>af :ALEFix<CR>


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

set clipboard+=unnamed

let g:mix_format_silent_errors = 1
let g:mix_format_on_save = 1
