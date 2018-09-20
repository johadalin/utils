""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic usability
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make things usably visible
set bg=dark

" syntax highlighting
syntax on

" display cursor position on ctrl-G
set ruler

" auto-indent to same point as previous line
" set autoindent

" Tab alterations. tab inserts 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Enable mouse functionality
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" More usability
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype specific tab behaviour
au FileType make setlocal noexpandtab
au FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

" Remember location in file
" If this doens't work, check the file permissions on the .viminfo file
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Vundle Plugins
" Conque-Shell allows opening any program in a vim buffer. Pretty gross, but fun
Plugin 'lrvick/Conque-Shell'
" Gives rainbow bracket highlighting. Becuase what are spare CPU cycles for
Plugin 'luochen1990/rainbow'
" Rust syntax highlighing
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration for the Rainbow plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
  \ 'guifgs': ['firebrick1','OrangeRed','DarkOrange','yellow1','OliveDrab1','green1','cyan1','DodgerBlue1','magenta1','purple1'],
  \ 'ctermfgs': [196, 202, 208, 226, 155, 46, 51, 33, 201, 141],
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fancypants column highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ColorColumn ctermbg=235
let &colorcolumn="80,100"
highlight LongLine ctermbg=88
call matchadd('LongLine', '\%<101v.\%>81v', 100)
highlight LongerLine ctermbg=89
call matchadd('LongerLine', '\%>100v', 100)
