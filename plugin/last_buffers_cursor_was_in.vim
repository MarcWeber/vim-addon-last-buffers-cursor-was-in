" written for hakunin to get rid of nasty complex plugins
"
" could be improved so that the list is stored on disk etc.
" remember that you can still use c-^ to toggle buffer
" using many tabs and mappings as show in vim-addon-other can also speed you
" and give O(1) access to about 10 files
" There are also more bloated plugins such as FuzzyFinder, ...

" vam#DefineAndBind('s:c','g:last_bufs', '{}')
if !exists('g:last_bufs') | let g:last_bufs = {} | endif | let s:c = g:last_bufs
let s:c = g:last_bufs
let s:c.max_files = get(s:c, 'max_files', 300)
let s:c.last_bufs = get(s:c, 'last_bufs', [])

fun! BufLastAdd()
  " if you use :cd or such names change as well, so use absolute path:
  let n = expand('%:p')
  " operates in place:
  call filter(s:c.last_bufs, 'v:val !='.string(n))
  call insert(s:c.last_bufs, n, 0)
  " trim:
  let s:c.last_bufs = s:c.last_bufs[0:s:c.max_files]
endf

augroup LAST_BUFS
  " this one is which you're most likely to use?
  autocmd BufEnter * call BufLastAdd()
augroup end

map \l :exec 'e '. fnameescape(tlib#input#List('s', 'last used buffers in order', g:last_bufs.last_bufs))<cr>
