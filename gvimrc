set guifont=Office\ Code\ Pro:h14
set columns=80
set lines=45
set title
set icon
set guioptions-=T
set guioptions-=m
set guioptions-=e
set guioptions-=r
set guioptions-=L

augroup GUI
  autocmd FocusLost * silent! wall
augroup END
