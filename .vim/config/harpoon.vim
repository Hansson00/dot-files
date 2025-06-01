"###########################################
" Simple Harpoon
"###########################################

let g:harpoon_files = []

function! HarpoonAdd()
  let current = expand('%:p')
  if empty(current)
    echo "No file to add!"
    return
  endif
  if index(g:harpoon_files, current) == -1
    call add(g:harpoon_files, current)
    echo "Added to Harpoon: " . current
  else
    echo "Already bookmarked."
  endif
endfunction

function! HarpoonList()
  if empty(g:harpoon_files)
    echo "Harpoon list is empty."
    return
  endif
  echo "Harpoon files:"
  for idx in range(len(g:harpoon_files))
    echo printf("%d: %s", idx + 1, g:harpoon_files[idx])
  endfor
endfunction

function! HarpoonGo(idx)
  if a:idx < 1 || a:idx > len(g:harpoon_files)
    echo "Invalid bookmark number."
    return
  endif
  execute 'edit' fnameescape(g:harpoon_files[a:idx - 1])
endfunction

function! HarpoonRemove(idx)
  if a:idx < 1 || a:idx > len(g:harpoon_files)
    echo "Invalid bookmark number."
    return
  endif
  call remove(g:harpoon_files, a:idx - 1)
  echo "Removed bookmark #" . a:idx
endfunction

"###########################################
" Keymaps
"###########################################

nnoremap ;a :call HarpoonAdd()<CR>
nnoremap ;; :call HarpoonList()<CR>
for i in range(1, 9)
  execute 'nnoremap ;' . i . ' :call HarpoonGo(' . i . ')<CR>'
endfor
command! -nargs=1 HarpoonRemove call HarpoonRemove(<f-args>)
nnoremap ;r :<C-u>HarpoonRemove<Space>

