if executable("pick")
  let g:pick_height = 20

  if ! has("gui_running")
    nnoremap <space><space> :call PickFile()<cr>
    nnoremap <space>s :call PickFileSplit()<cr>
    nnoremap <space>v :call PickFileVerticalSplit()<cr>
    nnoremap <space>b :call PickBuffer()<cr>
    nnoremap <space>] :call PickTag()<cr>
    nnoremap <space>\ :call PickSplitTag()<cr>
    nnoremap <space>t :call PickFileTab()<cr>
  endif
endif
