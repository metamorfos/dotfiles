fun! s:gm(short, cmd, ...)
  let silent = a:cmd =~ '\w$' ? '<silent>' : ''
  let cr = a:cmd =~ '\w$' ? '<cr>' : ''
  let extra = a:0 ? a:1 : ''
  exec "nmap" silent a:short ":" . a:cmd . cr . extra
endfunction

call s:gm('gs', 'Gstatus', '<c-n>')
call s:gm('gd', 'Gdiff')
call s:gm('gb', 'Gblame')
vnoremap <silent> gb :Gbrowse<cr>

augroup Fugitive
  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd FileType gitcommit nmap <silent> <buffer> q :q<CR>
  autocmd FileType git setlocal nolist
  autocmd FileType gitcommit setlocal
        \ nolist
        \ spell
        \ complete+=kspell

  autocmd FileType fugitiveblame nmap <buffer> § ~

augroup END
