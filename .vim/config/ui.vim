"###########################################
" Cursor line
"###########################################

set cursorline
highlight CursorLine guibg=#313548

"###########################################
" Status line
"###########################################

set laststatus=2
let &statusline = '%#StatusLineLeft#%f %y %m  %#StatusLineRight#%=[%{&fileencoding}] [%l/%L:%c]'

highlight StatusLineLeft guifg=#a0c8ff guibg=#1c1f2a ctermfg=111 ctermbg=237
highlight StatusLineRight guifg=#ffffaf guibg=#2a2a2a ctermfg=227 ctermbg=235

"###########################################
" Set thin cursor when in insert mode
"###########################################

if &term =~ "xterm"
  let &t_SI = "\e[6 q"   " Insert mode: bar cursor
  let &t_EI = "\e[2 q"   " Normal mode: block cursor
endif

" Custom yank highlighting
" highlight LightBlueMatch guifg=#a0c8ff guibg=#264f8c ctermfg=111 ctermbg=24
" :match LightBlueMatch /\%'\[\_.*\%']/
