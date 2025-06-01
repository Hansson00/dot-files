"###########################################
" Save on Ctrl + S
"###########################################

inoremap <C-S> <Esc>:w<CR>
vnoremap <C-S> <Esc>:w<CR>

"###########################################
" Alt movement
"###########################################

nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

"###########################################
" Explorer
"###########################################

nnoremap <Leader>e :Ex<CR>
nnoremap <Leader>E :Sex<CR> 
