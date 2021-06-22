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
Plug 'sunaku/vim-ruby-minitest'
Plug 'kien/rainbow_parentheses.vim'
Plug 'bling/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'mhinz/vim-startify'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'dense-analysis/ale'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" telescope
Plug 'nvim-telescope/telescope.nvim'

""""""""""""""""""""""""""""""""""""""
" Color Scheme
""""""""""""""""""""""""""""""""""""""

Plug 'cocopon/iceberg.vim'
" Very important, needs to be last
Plug 'ryanoasis/vim-devicons'
call plug#end()

"""
" Configure LSP and treesitter
"""
lua <<EOF
local lspconfig = require("lspconfig")

-- Neovim doesn't support snippets out of the box, so we need to mutate the
-- capabilities we send to the language server to let them know we want snippets.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.elixirls.setup{
    cmd = { "/home/axe/personal/elixir-ls/language_server.sh" };
}


require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF

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

""""""""""""""""""""""""""""""""""""""
" Key Bindings
""""""""""""""""""""""""""""""""""""""
" Map return in command mode to clear search buffer
nnoremap <cr> :noh<cr><cr>

" Map leader to \ because I like that instead of ,
let mapleader="\\"

" File navigation with ease

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


"""
" Compe settings
"""
set completeopt=menuone,noselect
lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    treesitter = true
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF


"""
" Telescope Settings
"""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua << EOF
require('telescope').setup{
  defaults = { file_ignore_patterns = {"node_modules", "_build", "deps"} }
}
EOF

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

set clipboard+=unnamed

let g:mix_format_silent_errors = 1
let g:mix_format_on_save = 1
