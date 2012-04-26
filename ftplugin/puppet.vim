set ts=2
set sts=2
set sw=2
set et
syn on

" Have detection for tagbar
let g:tagbar_type_puppet = {
      \ 'ctagstype' : 'puppet',
      \ 'kinds'     : [
        \ 'c:class',
        \ 's:site',
        \ 'n:node',
        \ 'd:define'
      \ ],
      \ 'sort'    : 1
\ }

