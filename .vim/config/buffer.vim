"###########################################
" Buffers
"###########################################

function! FzfBuffers()
  let buffers = []
  for buf in range(1, bufnr('$'))
    if buflisted(buf)
      let name = bufname(buf)
      if empty(name)
        let name = '[No Name]'
      endif
      call add(buffers, printf('%3d: %s', buf, name))
    endif
  endfor

  if empty(buffers)
    echo "No buffers to list"
    return
  endif

  " Sort buffers by buffer number numerically
  call sort(buffers, {a,b -> str2nr(matchstr(a, '^\s*\d\+')) - str2nr(matchstr(b, '^\s*\d\+'))})

  call fzf#run({
        \ 'source': buffers,
        \ 'sink': function('s:OpenBuffer'),
        \ 'options': '--prompt="Buffers> " --no-sort'
        \ })
endfunction

function! s:OpenBuffer(selected)
  let bufnr = matchstr(a:selected, '^\s*\d\+')
  execute 'buffer' bufnr
endfunction

"###########################################
" Keymaps
"###########################################

nnoremap <Leader>, :call FzfBuffers()<CR>
nnoremap <Leader>bd :bd<CR>
