call pathogen#infect() " pathogen
call pathogen#helptags()
filetype plugin indent on
syntax on

set nocompatible " IMproved
set clipboard=unnamed
set history=1000
set encoding=utf-8
let mapleader=","
set backspace=indent,eol,start
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

set t_Co=256 " visuals
colo solarized
set background=dark
set scrolloff=3
set laststatus=2

set nowritebackup " no backups
set nobackup
set noswapfile

set shiftwidth=2 " intendation
set tabstop=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set wrap

set incsearch " search
set hlsearch
set ignorecase
set smartcase
set gdefault
nnoremap n nzzzv
nnoremap N Nzzzv

"Plugins
  "NERDTree
  noremap <leader>n :NERDTreeToggle<cr>
  let g:NERDTreeWinSize = 25
  let NERDTreeChDirMode = 1
  let NERDTreeMinimalUI = 1

  "Gist
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 0
  let g:gist_show_privates = 1

  " CtrlP
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_custom_ignore = '*DS_Store*,*.dropbox*,*Icon*'
  let g:ctrlp_map = '<leader>,'
  let g:ctrlp_working_path_mode = 'cr'
  let g:ctrlp_match_window_reversed = 1
  let g:ctrlp_max_height = 15

  " NERDcommenter
  map cc <leader>c<space>

  " Solarized
  call togglebg#map("<F5>")

  " Fugitive
  nnoremap <leader>gs :Gstatus<CR>
  nnoremap <leader>gc :Gcommit<CR>
  
  " Powerline
  let g:Powerline_symbols = 'fancy'
  let g:Powerline_mode_n ='n'
  let g:Powerline_mode_i ='i'
  let g:Powerline_mode_v ='v'
  let g:Powerline_mode_V ='v-l'
  let g:Powerline_mode_cv ='v-c'

"Keybindings
  "LEADER bindings
  noremap <leader>s :%s//<left>
  noremap <leader>ev :vsplit ~/.vimrc<cr>
  noremap <LEADER><space> :nohls<cr>
  noremap <leader>v V`]
      
  " sudo to write
  cmap w!! w !sudo tee % >/dev/null<cr>

  " typos
    " commandmode
    command! -bang Q q<bang>
    command! -bang W w<bang>
    command! -bang WQ wq<bang>
    
    " my fingers sometimes slip
    nnoremap ; :
 
  " unbind
  noremap K <nop>
  noremap J <nop>

"movement
  " between panes
  map <c-j> <c-w>j
  map <c-k> <c-w>k
  map <c-l> <c-w>l
  map <c-h> <c-w>h
    
  " emacs movement in insert mode
  inoremap <c-a> <esc>I
  inoremap <c-e> <esc>A

    " ...and for the commandline
    cnoremap <c-a> <home>
    cnoremap <c-e> <end>
    cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>

  " easier to type
  noremap H ^
  noremap L g_

  " matching brackets
  noremap <tab> %
