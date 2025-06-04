function! Format()

  if &modified
    write
  endif

  let l:filename = expand('%:p')
  let l:cmd = 'clang-format -i '. shellescape(l:filename)
  echo 'Running: ' . l:cmd
  call system(l:cmd)

  edit!

endfunction

nnoremap <Leader>cf :call Format() <CR><CR>
