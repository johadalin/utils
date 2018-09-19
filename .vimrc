" Vundle setup start
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Vundle Plugins
"Plugin 'vim-scripts/Conque-Shell'
Plugin 'lrvick/Conque-Shell'
Plugin 'luochen1990/rainbow'
"Plugin 'rust-lang/rust.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Vundle setup end

"\ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
"\ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],

let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
  \ 'guifgs': ['purple1', 'magenta1', 'DodgerBlue1', 'cyan1', 'green1', 'OliveDrab1', 'yellow1', 'DarkOragnge', 'OrangeRed', 'firebrick1'],
  \ 'ctermfgs': [141, 201, 33, 51, 46, 155, 226, 208, 202, 196],
  \ 'operators': '_,_',
  \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
  \ 'separately': {
  \   '*': {},
  \   'tex': {
  \     'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
  \   },
  \   'lisp': {
  \     'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
  \   },
  \   'vim': {
  \     'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
  \   },
  \   'html': {
  \     'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
  \   },
  \   'css': 0,
  \ }
  \}


set bg=dark
"syntax highlighting
syntax on
"display cursor position on ctrl-G
set ruler
"auto-indent to same point as previous line
"set autoindent

"Tab alterations. tab inserts 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

set mouse=a


au FileType make setlocal noexpandtab
au FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

" Remember location in file
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

highlight ColorColumn ctermbg=235
let &colorcolumn="80,100"
highlight LongLine ctermbg=88
call matchadd('LongLine', '\%<101v.\%>81v', 100)
highlight LongerLine ctermbg=89
call matchadd('LongerLine', '\%>100v', 100)
