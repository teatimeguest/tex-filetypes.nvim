" Vim indent file
" Language: BibTool resource file

if exists('b:did_indent')
  finish
endif

setlocal nolisp
setlocal autoindent
setlocal smartindent
setlocal cinwords=

let b:undo_indent = 'setlocal lisp< autoindent< smartindent< cinwords<'
let b:did_indent = 1
