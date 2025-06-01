"###########################################
" Setup Grep
"###########################################

function! RipgrepFzfDynamic(query)
  if a:query == ''
    let l:query = input('Ripgrep search: ')
    if empty(l:query)
      return
    endif
  else
    let l:query = a:query
  endif

  call fzf#run({
        \ 'source': 'rg --column --line-number --no-heading --smart-case ' . shellescape(l:query) . ' || true',
        \ 'sink*': function('s:OpenRgResult'),
        \ 'options': '--ansi --prompt="Rg> " --delimiter :'
        \ })
endfunction

function! s:OpenRgResult(lines)
  for line in a:lines
    let parts = split(line, ':', 4)
    if len(parts) >= 3
      execute 'edit +' . parts[1] . ' ' . parts[0]
    endif
  endfor
endfunction

command! -nargs=? Rg call RipgrepFzfDynamic(<q-args>)

"###########################################
" Keymaps
"###########################################

nnoremap <Leader>sw :call RipgrepFzfDynamic(expand('<cword>'))<CR>
nnoremap <Leader>sg :Rg<CR>

"###########################################
" Setup fd
"###########################################

command! -nargs=+ Fd call s:fd_find(<q-args>)

function! s:fd_find(args)
  let results = systemlist('fd --type f --hidden --exclude .git ' . shellescape(a:args))
  if empty(results)
    echo "No files found matching: " . a:args
    return
  endif
  execute 'edit ' . fnameescape(results[0])
endfunction

"###########################################
" Keymaps
"###########################################

nnoremap <Leader>F yi":Fd <C-r>"<CR>
nnoremap <Leader>f :FZF<CR>
