" Vim syntax file
" Language: TeX Live's DEPENDS.txt format
"
" See <https://tug.org/texlive/pkgcontrib.html#deps>.

if exists('b:current_syntax')
  finish
endif

syn iskeyword @,-,46,48-57,_,192-255

syn keyword dependstxtTodo TODO FIXME XXX contained

syn match dependstxtError display "\S\+" contained

syn region dependstxtComment
  \ start="#" end="$" keepend oneline
  \ contains=dependstxtTodo,@Spell

syn region dependstxtHardDeps
  \ matchgroup=dependstxtHardDirective start="^\s*\%(hard\s\)\?\ze\s*\k"
  \ end="$" keepend oneline
  \ contains=dependstxtComment

syn region dependstxtSoftDeps
  \ matchgroup=dependstxtHardDirective start="^\s*soft\ze\s\+\k"
  \ end="$" keepend oneline
  \ contains=dependstxtComment

syn match dependstxtPackageDirective "^\s*package\ze\s\+\k"
  \ skipwhite nextgroup=dependstxtSubPackage

syn region dependstxtSubPackage fold contained
  \ matchgroup=dependstxtSubPackageName start="\k\+"
  \ end="^\ze\s*package\s\+\k"
  \ skipwhite nextgroup=dependstxtPackageDirective
  \ contains=
  \   dependstxtHardDeps,
  \   dependstxtSoftDeps,
  \   dependstxtComment,
  \   dependstxtError

hi def link dependstxtSubPackageName Title
hi def link dependstxtPackageDirective Define
hi def link dependstxtHardDirective Keyword
hi def link dependstxtSoftDirective dependstxtHardDirective
hi def link dependstxtHardDeps Identifier
hi def link dependstxtSoftDeps dependstxtHardDeps
hi def link dependstxtComment Comment
hi def link dependstxtError Error

let b:current_syntax = 'dependstxt'
