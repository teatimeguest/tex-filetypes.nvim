" Vim indent file
" Language: Property list of TeX font metric data

if exists('b:did_indent')
  finish
endif

setlocal nolisp
setlocal autoindent
setlocal cindent
setlocal cinkeys=0(,0),!^F,o,O
setlocal cinwords=
setlocal cinoptions=L0,:0,=0,h0,p0,t0,i0,+0,c0,(s,U1,Ws,)100,*0

let b:undo_indent =
  \ 'setlocal lisp< autoindent< cindent< cinkeys< cinwords< cinoptions<'
let b:did_indent = 1
