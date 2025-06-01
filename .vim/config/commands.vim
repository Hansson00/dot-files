let mapleader = " "
nnoremap <Space> <Nop>
set timeoutlen=500

set relativenumber
set number
set tabstop=2
set shiftwidth=2
set expandtab
set scrolloff=8
set nowrap
set mouse=a
set formatoptions=jcroqlnt
set termguicolors
set showmode
set showmatch
set hlsearch
set incsearch
set autoindent smartindent

"###########################################
" Enable persistent undo
"###########################################

set undofile
if !isdirectory(expand('~/.vim/undodir'))
    call mkdir(expand('~/.vim/undodir'), 'p')
endif

set undodir=~/.vim/undodir

"###########################################
" Mini lsp
"###########################################

syntax on
filetype plugin indent on
filetype plugin on
set keywordprg=:Man

