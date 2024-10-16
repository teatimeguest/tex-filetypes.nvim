" Vim syntax file
" Language: Property list of TeX font metric data
"
" References
" - <https://mirrors.ctan.org/info/knuth-pdf/texware/pltotf.pdf>
" - <https://mirrors.ctan.org/info/knuth-pdf/etc/vptovf.pdf>
" - <https://mirrors.ctan.org/info/ptex-manual/jfm.pdf>
" - <https://asciidwango.github.io/ptex/pl/index.html>

if exists('b:current_syntax')
  finish
endif

syn iskeyword @,48-57,192-255

syn keyword propertylistTodo TODO FIXME XXX contained

syn region propertylistEntry fold
  \ matchgroup=propertylistParens start="(" end=")"
  \ contains=
  \   propertylistEntry,
  \   propertylistComment,
  \   @propertylistKey,
  \   @propertylistValue

syn keyword propertylistProp
  \ CHECKSUM DESIGNSIZE DESIGNUNITS CODINGSCHEME FAMILY FACE
  \ SEVENBITSAFEFLAG HEADER FONTDIMEN LIGTABLE BOUNDARYCHAR CHARACTER

syn keyword propertylistUnspecified UNSPECIFIED
syn keyword propertylistBoolean TRUE FALSE

syn keyword propertylistNumericType C D F O R
syn match propertylistNumber display "[-+]\?\<\d\+\%(\.\d\+\)\?\>"
syn match propertylistNumber display "[-+]\?\.\d\+\>"
syn region propertylistHexNumber display
  \ matchgroup=propertylistNumericType start="\<H\s\+" end="\ze[^0-9A-F]"
syn match propertylistXeroxFaceCode display "\<[MBL][RI][RCE]\>"

syn keyword propertylistFontDimen
  \ SLANT SPACE STRETCH SHRINK XHEIGHT QUAD EXTRASPACE
  \ SUPDROP SUBDROP AXISHEIGHT DEFAULTRULETHICKNESS PARAMETER
syn match propertylistFontDimen display "\<\%(DENOM\|SUB\|DELIM\)[12]\>"
syn match propertylistFontDimen display "\<\%(NUM\|SUP\)[1-3]\>"
syn match propertylistFontDimen display "\<BIGOPSPACING[1-5]\>"

syn match propertylistCharacterProp display "\<CHAR\%(WD\|HT\|DP\|IC\)\>"
syn keyword propertylistCharacterProp NEXTLARGER VARCHAR
syn keyword propertylistVarCharProp TOP MID BOT REP

syn match propertylistLigTableLabel display "\<LABEL\%(\s\+BOUNDARYCHAR\)\?\>"
syn keyword propertylistLigTableCmd KRN STOP SKIP
syn match propertylistLigTableCmd display "/\?\<LIG\>/\?>\{0,2}"
syn match propertylistLigModifier display "[/>]"
  \ containedin=propertylistLigTableCmd

syn region propertylistParensInComment
  \ transparent
  \ start="(" end=")"
  \ contains=propertylistParensInComment
  \ contained
syn region propertylistComment fold
  \ matchgroup=propertylistComment start="(\s*COMMENT\>" end=")"
  \ contains=
  \   propertylistParensInComment,
  \   propertylistTodo,
  \   @Spell

syn cluster propertylistKey contains=
  \ propertylistProp,
  \ propertylistFontDimen,
  \ propertylistCharacterProp,
  \ propertylistLigTableLabel,
  \ propertylistLigTableCmd
syn cluster propertylistValue contains=
  \ propertylistUnspecified,
  \ propertylistBoolean,
  \ propertylistNumericType,
  \ propertylistNumber,
  \ propertylistHexNumber,
  \ propertylistXeroxFaceCode

syn match propertylistError ")"

hi def link propertylistTodo Todo
hi def link propertylistParens Operator
hi def link propertylistProp Keyword
hi def link propertylistUnspecified Constant
hi def link propertylistBoolean Boolean
hi def link propertylistNumber Number
hi def link propertylistHexNumber propertylistNumber
hi def link propertylistXeroxFaceCode String
hi def link propertylistFontDimen propertylistSubProp
hi def link propertylistCharacterProp propertylistSubProp
hi def link propertylistVarCharProp propertylistSubProp
hi def link propertylistLigTableLabel Label
hi def link propertylistLigTableCmd propretylistCmd
hi def link propertylistNumericType Type
hi def link propertylistLigModifier Delimiter
hi def link propertylistComment Comment
hi def link propertylistError Error

hi def link propertylistSubProp Identifier
hi def link propretylistCmd Function

" VPL (Virtual Property List) specific syntax:
syn keyword propertylistVTitle VTITLE
syn keyword propertylistVProp MAPFONT
syn keyword propertylistCharacterVProp MAP
syn match propertylistMapfontProp display
  \ "\<FONT\%(NAME\|AREA\|CHECKSUM\|AT\|DSIZE\)\>"
syn keyword propertylistMapCmd
  \ SELECTFONT SETCHAR SETRULE MOVERIGHT MOVELEFT MOVEUP MOVEDOWN
  \ PUSH POP SPECIAL SPECIALHEX
syn region propertylistPostScript display
  \ matchgroup=propertylistPostScriptTag start="\<ps:" end="\ze)"

syn cluster propertylistKey add=
  \ propertylistVTitle,
  \ propertylistVProp,
  \ propertylistCharacterVProp,
  \ propertylistMapfontProp,
  \ propertylistMapCmd
syn cluster propertylistValue add=propertylistPostScript

hi def link propertylistVTitle Title
hi def link propertylistVProp propertylistProp
hi def link propertylistCharacterVProp propertylistCharacterProp
hi def link propertylistMapfontProp propertylistSubProp
hi def link propertylistMapCmd propretylistCmd
hi def link propertylistPostScript Special
hi def link propertylistPostScriptTag PreProc

" JPL (Japanese Property List) specific syntax:
syn keyword propertylistJProp
  \ CHARSINTYPE TYPE GLUEKERN DIRECTION EXTRASTRETCH EXTRASHRINK
syn keyword propertylistGlueKernCmd GLUE
syn keyword propertylistDirection YOKO TATE

syn region propertylistJHexNumber display
  \ matchgroup=propertylistJNumericType start="\<[JKU]\s\+" end="\ze[^0-9A-F]"

syn cluster propertylistKey add=propertylistJProp,propertylistGlueKernCmd
syn cluster propertylistValue add=propertylistDirection,propertylistJHexNumber

hi def link propertylistJProp propertylistProp
hi def link propertylistGlueKernCmd propertylistLigTableCmd
hi def link propertylistDirection String
hi def link propertylistJHexNumber propertylistHexNumber
hi def link propertylistJNumericType propertylistNumericType

let b:current_syntax = 'propertylist'
