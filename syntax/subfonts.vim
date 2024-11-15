" Vim syntax file
" Language: Subfont definition files
"
" References:
" - <https://www.tug.org/texlive//devsrc/Master/texmf-dist/doc/man/man1/ttf2tfm.man1.pdf>

if exists('b:current_syntax')
  finish
endif

syn keyword subfontsTodo TODO FIXME XXX contained

syn match subfontsLineContinuation "\\$"

syn region subfontsSubfont transparent
  \ matchgroup=subfontsInfix start="\S\+"
  \ end="$"
  \ contains=
  \   subfontsLineContinuation,
  \   @subfontsRanges

syn cluster subfontsRanges
  \ contains=
  \   subfontsCodepoint,
  \   subfontsOffset,
  \   subfontsRange

syn match subfontsCodepoint display "\<0x\x\+\>" contained
syn match subfontsCodepoint display "\<\d\+\>" contained
syn match subfontsCodepoint display "\<0\o\+\>" contained

syn match subfontsOffset display
  \ "\<\(%0x\x\+\|\d\+\|0\o\+\):"
  \ contained
  \ contains=subfontsOffsetDelimiter
  \ skipwhite nextgroup=subfontsRange

syn match subfontsOffsetDelimiter display ":" contained

syn match subfontsRange display
  \ "\<\%(0x\x\+\|\d\+\|0\o\+\)_\%(0x\x\+\|\d\+\|0\o\+\)\>"
  \ contained
  \ contains=subfontsRangeDelimiter

syn match subfontsRangeDelimiter display "_" contained

syn region subfontsComment
  \ start="#"
  \ end="$"
  \ contains=
  \   subfontsLineContinuation,
  \   subfontsTodo,
  \   @Spell

hi def link subfontsTodo Todo
hi def link subfontsLineContinuation Special
hi def link subfontsInfix Identifier
hi def link subfontsCodepoint Number
hi def link subfontsRange Number
hi def link subfontsRangeDelimiter Operator
hi def link subfontsOffset Label
hi def link subfontsOffsetDelimiter Delimiter
hi def link subfontsComment Comment

let b:current_syntax = 'subfonts'
