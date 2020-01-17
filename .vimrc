" vim: set foldmethod=marker:
"
" This file is folded by default. Use:
" -  zR to expand all folds.
" -  zM to close all folds.
" -  zc to close a single fold
" -  zo to open a single fold
" -  za to toggle a fold (open a closed one or close an open one. This is
"    genrally more useful than zc or zo).

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins / Vundle setup {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" First time setup - you will need to clone vundle, running:
"   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" To install plugins, use Vim command `:PluginInstall`

set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Vundle Plugins

" Gives rainbow bracket highlighting. Becuase what are spare CPU cycles for
Plugin 'luochen1990/rainbow'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'git@gitlab.datcon.co.uk:ajh/clearwater.vim.git'

" To install the YouCompleteMe plugin, you need to build it locally after it's been pulled down.
" First, run the Vundle :PluginInstall to let it clone the code, then run:
"   cd ~/.vim/bundle/YouCompleteMe
"   python3 install.py --clang-completer
if v:version >= 704  " YouCompleteMe requires a recent version of Vim.
  Plugin 'Valloric/YouCompleteMe'
endif

" YouCompleteMe settings {{{

" Don't clutter the UI with compilation warnings/errors.
let g:ycm_enable_diagnostic_signs=0
let g:ycm_enable_diagnostic_highlighting=0
let g:ycm_echo_current_diagnostic=0

" Don't complete in comments
let g:ycm_complete_in_comments=0

" The YcmCompleter has a bunch of useful functions. Map some of the more commen
" ones to keybindings.

" Type-aware goto declaration. This is useful when wanting to find the
" declaration of a function with a short, common name, that may be used in many
" different classes or projects.
nmap <leader>yg :YcmCompleter GoTo<cr>

" Print the type of the variable under the cursor.
nmap <leader>yt :YcmCompleter GetType<cr>
" }}}


" AJH PLUGINS {{{

" Some configuration taken from https://github.com/AlexHockey/dotfiles/tree/master/dotfiles
" Not tested or used yet, but intent to at some point
"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'SirVer/ultisnips'
"Plugin 'tpope/vim-fugitive'
"Plugin 'tpope/vim-endwise'
"Plugin 'tpope/vim-abolish'
"Plugin 'vim-indent-object'
"Plugin 'kana/vim-textobj-user'
"Plugin 'glts/vim-textobj-comment'
"Plugin 'AlexHockey/current-function.vim'
"
"" Language-specific plugins.
"Plugin 'vim-ruby/vim-ruby'
"Plugin 'jnwhiteh/vim-golang'
"Plugin 'rust-lang/rust.vim'
"Plugin 'greyblake/vim-preview'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'vim-scripts/DoxygenToolkit.vim'
"Plugin 'vim-scripts/supp.vim'
"Plugin 'mustache/vim-mustache-handlebars'
"Plugin 'cespare/vim-toml'
"Plugin 'Glench/Vim-Jinja2-Syntax'
"Plugin 'ekalinin/Dockerfile.vim'
"
"" Colorschemes
"Plugin 'joshdick/onedark.vim'
"Plugin 'drewtempelmeyer/palenight.vim'
"Plugin 'dracula/vim'
"Plugin 'haishanh/night-owl.vim'
"
" }}}


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
" }}}

" Find / Replace {{{

" Highlight search matches.
set hlsearch
hi Search ctermbg=DarkGrey
"hi Search ctermfg=DarkRed

" Ignore case except when the search term contains uppercase (that is what
" ignorecase and smartcase do).
" set ignorecase
" set smartcase

" When searching through a file, center the match in the window. If you don't
" do this Vim can put the match at the very bottom/top of the window, which
" means you can't seen the code surrounding the match very well.
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap <kMultiply> *zz
" nnoremap # #zz

" Make Ctrl-C escape *and* clear the current highlighting.
nmap <C-C> <esc>:noh<cr>

" }}}

" Configuration for the Rainbow plugin {{{
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
" }}}

" Usability {{{
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

" Set backspace/delete to wrap over lines
set backspace=indent,eol,start

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

" Make the unnamed register the same as the clipboard register.  The unnamed
" register is where text is stored when you yank it.  By making it the same
" as the clipboard, yanking and pasting in Vim affects the system clipboard.
" http://vim.wikia.com/wiki/VimTip21
set clipboard=unnamedplus

" Make tab completion work more like how it does on Linux.
set completeopt=longest,menuone
set wildmode=longest,list,full

" Ignore binary files in tab completion, Ctrl-P, etc.
set wildignore+=*.o,*.so,*.git/*,*.svn/*

" Show tabs and wrapped lines.
"set list
"set listchars=tab:▸\ ,
"let &showbreak='▸ '

" Strip trailing whitespace on save - for all file types.
" See http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

" Don't draw during macros, to improve performance
set lazyredraw

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw file explorer settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open a file explorer up. Can use :Explore :Sexplore or :Vexplore (normal, split, vsplit)
" These options set up the config, as commented.
" Set the list style to tree
let g:netrw_liststyle = 3
" Don't display the banner by default
let g:netrw_banner = 0
" Open selected files in a new vsplit
let g:netrw_browse_split = 2
" Set the netrw to take up a smaller percentage of screen real estate
let g:netrw_winsize = 15
" When opening a file with 'v', split it to the right, not left
"let g:netrw_altv = 1

" DISABLED ATM as i don't like it, but might try again later
" Auto start netrw in Vexplore mode on starting Vim
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" }}}

" Fancypants column highlighting {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ColorColumn ctermbg=235
let &colorcolumn="80,100"
highlight LongLine ctermbg=88
call matchadd('LongLine', '\%<101v.\%>81v', 100)
highlight LongerLine ctermbg=89
call matchadd('LongerLine', '\%>100v', 100)
" }}}

" Less fancy row highlighting {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display current line
set cursorline
highlight CursorLine cterm=NONE ctermbg=235
" }}}

" Status Line {{{
" Set the status line to be visible at all times.
set laststatus=2

" Use a nice color scheme for the status line. Dracula is more visualy intense
" than onedark (the scheme used for the rest of the editor) so this makes the
" statsu line stand out a bit more.
"let g:airline_theme = 'dracula'

" Make airline use the powerline fonts, so we get a pretty looking line with
" chevrons, git branch symbols, etc.
let g:airline_powerline_fonts = 1

"" By default the central section of the statusline contains the current file. As
"" that is displayed at the top of the window, we can use it for something
"" different. I find that displaying the current function is the most useful.
"let g:airline_section_c = '%{GetFunctionUnderCursor()}'
"" }}}

" Grep Settings {{{

" Make grep ignore common false positives - binary files (-I) and tags.
set grepprg=grep\ -nI\ --exclude\ 'tags'\ $*\ /dev/null\ --exclude-dir=.svn\ --exclude\ \*.js\ --exclude\ \*.memcheck

" Grep for word under the cursor.
nnoremap <Leader>gw :grep -rw <cword> .<CR>
" }}}

" Tagging {{{

" Search for tag files in the current directory, and all parent directories.
set tags=tags;/

" Navigate through several possible tag matches.
nnoremap <F7> :tprev<cr>
nnoremap <F8> :tnext<cr>

" Rebuild tags. This function searches up from the current directory until it
" finds a directory with a tags file. It then rebuilds this tags file by
" calling `ctags .`
function! RebuildTags(cwd)
python << EOF
import vim, os
cwd = vim.eval("a:cwd")
elems = cwd.split(os.sep)
elems = list(reversed(elems))

for levels_up in range(len(elems)):
  target = os.sep.join(reversed(["tags"] + elems[levels_up : ]))
  if os.path.isfile(target):
    print "Rebuilding tagfile '%s' ..." % target
    os.system("( cd $( dirname %s ) && ctags . )" % target)
    print "Done"
EOF
endfunction
command! Tagme call RebuildTags(getcwd())
" }}}


