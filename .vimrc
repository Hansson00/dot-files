" let mapleader = " "
" nnoremap <Space> <Nop>
" set timeoutlen=500
"
" set relativenumber
" set number
" set tabstop=2
" set shiftwidth=2
" set expandtab
" set scrolloff=8
" set nowrap
" set mouse=a
" set formatoptions=jcroqlnt
" set termguicolors
" set showmode
" set showmatch
" set hlsearch
" set incsearch
"
" " Custom yank highlighting
" " highlight LightBlueMatch guifg=#a0c8ff guibg=#264f8c ctermfg=111 ctermbg=24
" " :match LightBlueMatch /\%'\[\_.*\%']/
"
" " Cursor line
" set cursorline
" highlight CursorLine guibg=#313548
"
" " Status line
" set laststatus=2
" let &statusline = '%#StatusLineLeft#%f %y %m  %#StatusLineRight#%=[%{&fileencoding}] [%l/%L:%c]'
"
" highlight StatusLineLeft guifg=#a0c8ff guibg=#1c1f2a ctermfg=111 ctermbg=237
" highlight StatusLineRight guifg=#ffffaf guibg=#2a2a2a ctermfg=227 ctermbg=235
"
" " Set thin cursor when in insert mode
" if &term =~ "xterm"
"   let &t_SI = "\e[6 q"   " Insert mode: bar cursor
"   let &t_EI = "\e[2 q"   " Normal mode: block cursor
" endif
" set autoindent smartindent
"
" " Setup Grep
" function! RipgrepFzfDynamic(query)
"   if a:query == ''
"     let l:query = input('Ripgrep search: ')
"     if empty(l:query)
"       return
"     endif
"   else
"     let l:query = a:query
"   endif
"
"   call fzf#run({
"         \ 'source': 'rg --column --line-number --no-heading --smart-case ' . shellescape(l:query) . ' || true',
"         \ 'sink*': function('s:OpenRgResult'),
"         \ 'options': '--ansi --prompt="Rg> " --delimiter :'
"         \ })
" endfunction
"
" function! s:OpenRgResult(lines)
"   for line in a:lines
"     let parts = split(line, ':', 4)
"     if len(parts) >= 3
"       execute 'edit +' . parts[1] . ' ' . parts[0]
"     endif
"   endfor
" endfunction
"
" command! -nargs=? Rg call RipgrepFzfDynamic(<q-args>)
"
" " Map <Leader>sw to search word under cursor
" nnoremap <Leader>sw :call RipgrepFzfDynamic(expand('<cword>'))<CR>
"
" " Map <Leader>rg to prompt input
" nnoremap <Leader>sg :Rg<CR>
"
"
" " Setup fd
" command! -nargs=+ Fd call s:fd_find(<q-args>)
"
" function! s:fd_find(args)
"   let results = systemlist('fd --type f --hidden --exclude .git ' . shellescape(a:args))
"   if empty(results)
"     echo "No files found matching: " . a:args
"     return
"   endif
"   execute 'edit ' . fnameescape(results[0])
" endfunction
"
" nnoremap <Leader>F yi":Fd <C-r>"<CR>
" nnoremap <Leader>f :FZF<CR>
"
" " Gd behaviour
" " ctags -R .
" " :set tags=./tags;
"
" nnoremap gd <C-]>
"
" " Save on Ctrl + S
" inoremap <C-S> <Esc>:w<CR>
" vnoremap <C-S> <Esc>:w<CR>
"
" " Alt movement
" nnoremap <C-j> :m .+1<CR>
" nnoremap <C-k> :m .-2<CR>
" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
" vnoremap <C-j> :m '>+1<CR>gv=gv
" vnoremap <C-k> :m '<-2<CR>gv=gv
"
" " Enable persistent undo
" set undofile
" if !isdirectory(expand('~/.vim/undodir'))
"     call mkdir(expand('~/.vim/undodir'), 'p')
" endif
"
" set undodir=~/.vim/undodir
"
" " Mini lsp
" syntax on
" filetype plugin indent on
" filetype plugin on
" set keywordprg=:Man
"
" " Buffers
" nnoremap <Leader>bd :bd<CR>
"
" " Explorer
" nnoremap <Leader>e :Ex<CR>
" nnoremap <Leader>E :Sex<CR> 

source ~/.vim/config/ui.vim
source ~/.vim/config/commands.vim
source ~/.vim/config/grep_fd.vim
source ~/.vim/config/harpoon.vim
source ~/.vim/config/buffer.vim
