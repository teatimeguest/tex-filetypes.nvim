" Vim syntax file
" Language: TeX Live Database/Object/Source module
"
" References:
" - <https://www.tug.org/texlive/doc/tlpkgdoc/TLPSRC.html>
" - <https://www.tug.org/texlive/doc/tlpkgdoc/TLPOBJ.html>
" - <https://www.tug.org/texlive/doc/tlpkgdoc/TLPDB.html>

if exists('b:current_syntax')
  finish
endif

syn iskeyword @,-,48-57,_,192-255

syn keyword tlpdbTodo TODO FIXME XXX contained

syn match tlpdbLineContinuation "\\$" containedin=ALL

syn region tlpdbComment
  \ start="^#"
  \ excludenl end="$"
  \ contains=tlpdbTodo,@Spell

syn region tlpdbComment
  \ start="\s\zs#"
  \ excludenl end="$"
  \ contains=tlpdbTodo,@Spell
  \ containedin=ALLBUT,tlpdbComment

syn keyword tlpdbCategory Collection Scheme TLCore Package ConTeXt contained
syn keyword tlpdbCategory Documentation contained

syn keyword tlpdbAction addMap addMixedMap AddHyphen AddFormat contained
syn keyword tlpdbAction shortcut filetype fileassoc script contained

syn match tlpdbInternalPackage "\<00texlive\.\k\+" display contained
syn match tlpdbInternalPackage "\<00texlive-\k\+" display contained

syn match tlpdbNumber "\.\@1<!\<\d\+\>\.\@!" display contained
syn match tlpdbChecksum "\<\x\{128}\>" display contained
syn region tlpdbString contained start=+"+ end=+"+

syn cluster tlpdbLiteral
  \ contains=
  \   tlpdbNumber,
  \   tlpdbChecksum,
  \   tlpdbString

syn match tlpdbAttribute "\s\k\+=" display contained
  \ contains=tlpdbEqualSign
  \ nextgroup=@tlpdbLiteral

syn match tlpdbArch "\.\zsARCH\>" display contained

syn match tlpdbEqualSign "=" display contained

syn region tlpdbField
  \ matchgroup=tlpdbKey start="^\k\+"
  \ end="$"
  \ contains=@tlpdbLiteral,tlpdbAction,tlpdbAttribute

syn region tlpdbFieldName
  \ matchgroup=tlpdbKey start="^name\>"
  \ end="$"
  \ contains=tlpdbArch,tlpdbInternalPackage

syn region tlpdbFieldCategory
  \ matchgroup=tlpdbKey start="^category\>"
  \ end="$"
  \ contains=tlpdbCategory

syn region tlpdbField
  \ matchgroup=tlpdbKey start="^\%(short\|long\)desc\>"
  \ end="$"

syn region tlpdbField
  \ matchgroup=tlpdbKey start="^depend\>"
  \ end="$"
  \ contains=tlpdbArch

syn region tlpdbFieldPattern
  \ matchgroup=tlpdbKey start="\%(src\|run\|doc\|bin\)pattern\>"
  \ end="$"
  \ contains=tlpdbVariableExpansion

syn match tlpdbVariableExpansion "\${\k\+}" display contained
  \ contains=tlpdbVariable
syn match tlpdbVariableExpansion "\$\k\+\>" display contained
  \ contains=tlpdbVariable

syn match tlpdbVariable "\k\+" display contained

syn region tlpdbListItem
  \ start="^\s\ze[^[:blank:]#]"
  \ end="$"
  \ contains=tlpdbAttribute

syn sync minlines=5 maxlines=10

hi def link tlpdbTodo Todo
hi def link tlpdbLineContinuation Special
hi def link tlpdbEqualSign Operator
hi def link tlpdbComment Comment
hi def link tlpdbCategory Type
hi def link tlpdbAction Function
hi def link tlpdbNumber Number
hi def link tlpdbChecksum String
hi def link tlpdbString String
hi def link tlpdbInternalPackage Define
hi def link tlpdbArch Macro
hi def link tlpdbAttribute Identifier
hi def link tlpdbKey Keyword
hi def link tlpdbFieldName Title
hi def link tlpdbVariableExpansion Delimiter
hi def link tlpdbVariable Identifier
hi def link tlpdbListItem Include

let b:current_syntax = 'tlpdb'
