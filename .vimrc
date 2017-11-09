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

" Commenting blocks of code.
au FileType c,cpp,java,scala let b:comment_leader = '// '
au FileType sh,ruby,python   let b:comment_leader = '# '
au FileType conf,fstab       let b:comment_leader = '# '
au FileType tex              let b:comment_leader = '% '
au FileType mail             let b:comment_leader = '> '
au FileType vim              let b:comment_leader = '" '
"noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
"noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

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
