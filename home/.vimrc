"General settings
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on
set nocompatible " IMproved
set clipboard=unnamed
set autoread
set history=1000
set encoding=utf-8
let mapleader=","
set backspace=indent,eol,start

"Visual thingys 
set t_Co=256
colo solarized
set background=dark
set scrolloff=3
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"Plugins
  "NERDTree
  noremap <leader>n :NERDTreeToggle<cr>
  let NERDTreeChDirMode = 1
  let g:NERDTreeWinSize = 25
  let NERDTreeHighlightCursorline=1

  "Gist
  let g:gist_clip_command = 'pbcopy'
  let g:gist_detect_filetype = 1
  let g:gist_open_browser_after_post = 0
  let g:gist_show_privates = 1

  " Command-T
  let g:CommandTMaxHeight = 15
  noremap <leader>t :CommandT<CR>

  " NERDcommenter
  map cc <leader>c<space>

  " Solarized
  call togglebg#map("<F5>")

  " Fugitive
  nnoremap <leader>gs :Gstatus<CR>
  nnoremap <leader>gc :Gcommit<CR>

"Keybindings
  "LEADER bindings
  noremap <leader>q :q!<cr>
  noremap <leader>l :set nu!<cr>
  noremap <leader>sr :%s//<left>
  noremap <leader>ev :vsplit ~/.vimrc<cr>
  noremap <leader>sv :vsplit<cr>
  noremap <leader>sp :split<cr>
  noremap <LEADER><space> :nohls<cr>  
  noremap <leader>pm :!markdown % \|browser<cr>
      
  " sudo to write
  cmap w!! w !sudo tee % >/dev/null<cr>

  " typos
    " commandmode
    command! -bang Q q<bang>
    command! -bang W w<bang>
    
    " my fingers sometimes slip
    nnoremap ; :
 
  " unbind
  noremap K <nop>
  noremap J <nop>

"movement
  " buffers/panes
  map <c-j> <c-w>j
  map <c-k> <c-w>k
  map <c-l> <c-w>l
  map <c-h> <c-w>h
    
  " heresy 
  inoremap <c-a> <esc>I
  inoremap <c-e> <esc>A

    " ..comandline
    cnoremap <c-a> <home>
    cnoremap <c-e> <end>
    cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>

  " true-er vim movement
  noremap H ^
  noremap L g_

  " matching brackets
  noremap <tab> %

" no swap or backup 
set nowritebackup
set nobackup
set noswapfile

" sane intendation 
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab 
set autoindent

" wraps
set wrap 
set linebreak 
set textwidth=79

" search 
set incsearch 
set hlsearch 
set ignorecase
set smartcase                                
set gdefault

" keep search matches in the middle
nnoremap n nzzzv
nnoremap N Nzzzv

