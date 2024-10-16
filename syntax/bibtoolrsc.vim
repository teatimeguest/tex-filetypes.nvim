" Vim syntax file
" Language: BibTool resource file
" Version: 2.68
"
" See <https://www.ctan.org/pkg/bibtool>.

if exists('b:current_syntax')
  finish
endif

syn iskeyword @,-,48-57,_,192-255
syn case ignore

syn keyword bibtoolrscTodo TODO FIXME XXX contained

syn region bibtoolrscComment display
  \ start="[#%]" end="$"
  \ contains=bibtoolrscTodo,@Spell
  \ keepend oneline

syn keyword bibtoolrscBoolean on off t true yes
syn match bibtoolrscNumber display contained "\<\d\+\>"

syn region bibtoolrscString display contained start=+"+ end=+"+
syn region bibtoolrscString display contained
  \ start=+{+ end=+}+
  \ contains=bibtoolrscString

syn match bibtoolrscFormatSpec display contained
  \ "%[+-]\?\%(\d\+\)\?\.\?\%(\d\+\)\?#\?[pndDsTtWw]([$@]\?\k\+\%(\.\k\+\)*)"
  \ contains=bibtoolrscField,bibtoolrscPseudoField
  \ containedin=bibtoolrscString
syn match bibtoolrscField display contained "(\zs.\{-}\ze)"
syn match bibtoolrscPseudoField display contained "(\zs[$@].\{-}\ze)"
syn match bibtoolrscAlternative display contained "#"
  \ containedin=bibtoolrscString

syn match bibtoolrscNameSpec display contained
  \ "%[+*-]\?\%(\d\+\)\?\.\?\%(\d\+\)\?[flvj]\%(\[.\{-}\]\)\{0,3}"
  \ contains=bibtoolrscNameString
  \ containedin=bibtoolrscString
syn match bibtoolrscNameString display contained "\[\zs.\{-}\ze\]"

syn match bibtoolrscMacro display contained
  \ "\\\%(\a\+\|.\)"
  \ containedin=bibtoolrscString

syn cluster bibtoolrscValue
  \ contains=
  \   bibtoolrscBoolean,
  \   bibtoolrscNumber,
  \   bibtoolrscString
syn match bibtoolrscDot display contained "\."
syn match bibtoolrscEqualSign display contained "="
  \ skipwhite nextgroup=@bibtoolrscValue
  \ containedin=bibtoolrscString

syn match bibtoolrscKey display "^\s*\zs\k\+\%(\.\k\+\)*\>"
  \ contains=bibtoolrscDot
  \ skipwhite nextgroup=bibtoolrscEqualSign,@bibtoolrscValue

hi def link bibtoolrscKey Keyword
hi def link bibtoolrscDot Delimiter
hi def link bibtoolrscEqualSign Operator
hi def link bibtoolrscBoolean Boolean
hi def link bibtoolrscNumber Number
hi def link bibtoolrscString String
hi def link bibtoolrscFormatSpec Delimiter
hi def link bibtoolrscField Identifier
hi def link bibtoolrscPseudoField Macro
hi def link bibtoolrscAlternative Operator
hi def link bibtoolrscNameSpec Delimiter
hi def link bibtoolrscNameString String
hi def link bibtoolrscComment Comment
hi def link bibtoolrscTodo Todo
if has('nvim')
  hi def link bibtoolrscMacro @function.latex
else
  hi def link bibtoolrscMacro Function
endif

let b:current_syntax = 'bibtoolrsc'
