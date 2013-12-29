set nocompatible " IMproved
filetype off
set rtp+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))
set clipboard=unnamed
set history=1000
set encoding=utf-8
let mapleader=" "
set backspace=indent,eol,start
set wildmenu
set hidden
set ttyfast
set ttimeout
set ttimeoutlen=50
set t_te= t_ti=
set splitright
set tags=.git/tags,tags
set shiftround

" plugins
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build' : { 'mac' : 'make -f make_mac.mak' } }
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'teoljungberg/vim-grep'
NeoBundle 'teoljungberg/vim-visual-star-search'
NeoBundle 'teoljungberg/vim-test'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-liquid'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'wincent/Command-T', { 'build' : { 'mac' : 'ruby ruby/command-t/extconf.rb && make -f ruby/command-t/Makefile' } }
runtime macros/matchit.vim

colo solarized " visuals
set t_Co=256
set background=light
set scrolljump=-50
set laststatus=2
syntax on
filetype plugin indent on
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set winwidth=100

set backupskip=/tmp/*,/private/tmp/*
set directory=~/.cache/vim/swap//
set backupdir=~/.cache/vim/backup//
set undodir=~/.cache/vim/undo//

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap

set ignorecase " search
set incsearch
set smartcase
set gdefault
noremap n nzzzv
noremap N Nzzzv
noremap * *zzzv
noremap # #zzzv

" command-t
noremap <leader><leader> :CommandT<cr>
noremap <leader>f :CommandTFlush<cr>:CommandT<cr>
let g:CommandTMaxFiles=15000
let g:CommandTMaxHeight=30
let g:CommandTMatchWindowReverse=1
let g:CommandTAlwaysShowDotFiles=1
let g:CommandTScanDotDirectories=1
let g:CommandTCancelMap=['<esc>', '<C-c>']
let g:CommandTSelectNextMap = ['<C-j>', '<ESC>OB']
let g:CommandTSelectPrevMap = ['<C-k>', '<ESC>OA']
set wildignore+=.git/**,public/assets/**,vendor/**,log/**,tmp/**,Cellar/**,app/assets/images/**,_site/**,home/.vim/bundle/**,pkg/**,**/.gitkeep,**/.DS_Store,**/*.netrw*

" fugitive
noremap <leader>gs :Gstatus<cr>
noremap <leader>gd :Gdiff<cr>

" vim-grep
noremap <leader>gg :Grep!<space>
noremap <leader>ga :GrepAdd!<space>

" vim-test
noremap <leader>t :RunTestFile<cr>
noremap <leader>l :RunNearestTest<cr>

" unimpaired
map ( [
map ) ]

" surround
let g:surround_{char2nr('%')} = "<% \r %>"
let g:surround_{char2nr('=')} = "<%= \r %>"
let g:surround_{char2nr('c')} = "<%- \r %>"
let g:surround_{char2nr('#')} = "#{\r}"

" dispatch
noremap <silent> <leader>c :Copen!<cr>

"leader bindings
noremap <leader>sr :%s//<left>
noremap <leader>v V`]

" sudo to write
cmap w!! w !sudo tee % >/dev/null<cr>

" convenience mappings
command! W w
command! Q q
command! Wq wq
command! Wqa wqa
noremap Y y$
noremap ö :
noremap Ö :
noremap Q <nop>
noremap K <nop>
cnoremap <c-g> <c-f>
noremap g" /\v<<C-r>*><cr>
noremap <leader>g" :Grep! "<C-r>*"<cr>
vnoremap s "_c
noremap ' `
noremap 0 ^

" open files in directory of current file
cnoremap %% <c-r>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" emacs movement
inoremap <c-e> <esc>A
inoremap <c-a> <esc>I
cnoremap <c-a> <home>

" move between panes
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

augroup vimrcEx
  autocmd!
  " jumps to the last known position in a file
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  autocmd BufReadPost fugitive://* set bufhidden=delete

  autocmd FileType help,gitcommit,qf map <silent> <buffer> q :q<CR>

  " for writing in vim
  autocmd FileType markdown,text,liquid setlocal fo=crotqaw comments=n:&gt;
  autocmd FileType gitcommit,qf,git setlocal nolist

  autocmd FileType html,javascript,css,markdown,liquid setlocal ai sw=4 sts=4 et

  autocmd FileType ruby imap <silent> <buffer> ö :
augroup END
