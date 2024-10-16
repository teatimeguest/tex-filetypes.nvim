" Vim syntax file
" Language: ChkTeX config file
" Version: 1.7.9

if exists('b:current_syntax')
  finish
endif

syn keyword chktexrcTodo TODO FIXME XXX contained

syn match chktexrcNumber display '\<\d\+\>' contained

syn match chktexrcEscapeSequence display
  \ '![ "#!{}\[\]=bnrtf]' contained
syn match chktexrcEscapeSequence display
  \ '!x[0-9,a-f]\{2}' contained
syn match chktexrcEscapeSequence display
  \ '!d\%([01]\d\d\|2\%([0-4]\d\|5[0-5]\)\)' contained
syn match chktexrcEscapeSequence display
  \ '!\%([0-2]\d\d\|3[0-6]\d\|37[0-7]\)' contained

syn match chktexrcFormatSpecifier display '%[bcdfiIklmnurst%]' contained

syn match chktexrcString display
  \ '"\%(!.\|[^!]\)*"'
  \ contains=chktexrcEscapeSequence,chktexrcFormatSpecifier
  \ contained

syn match chktexrcPCREComment display
  \ '(?\%(!.\|[^!)]\)*)'
  \ contains=chktexrcEscapeSequence
  \ contained

syn region chktexrcComment start='#' end='$' contains=chktexTodo,@Spell

syn keyword chktexrcQuoteStyle Traditional Logical contained
syn keyword chktexrcCmdSpaceStyle Ignore InterWord InterSentence Both contained

syn keyword chktexrcKeyword
  \ Abbrev
  \ CenterDots
  \ CmdLine
  \ CmdSpaceStyle
  \ DashExcpt
  \ HyphDash
  \ IJAccent
  \ ItalCmd
  \ Italic
  \ Linker
  \ LowDots
  \ MathCmd
  \ MathEnvir
  \ MathRoman
  \ NoCharNext
  \ NonItalic
  \ NotPreSpaced
  \ NumDash
  \ OutFormat
  \ PostLink
  \ Primitives
  \ QuoteStyle
  \ Silent
  \ TabSize
  \ TeXInputs
  \ TextCmd
  \ TextEnvir
  \ UserWarn
  \ UserWarnRegex
  \ VerbClear
  \ VerbEnvir
  \ WipeArg
  \ WordDash
  \ nextgroup=
  \   chktexrcCaseInsensitiveList,
  \   chktexrcCaseSensitiveList,
  \   chktexrcEqualsSign
  \ skipempty skipwhite

syn region chktexrcCaseSensitiveList fold
  \ matchgroup=chktexrcOperator
  \ start="{" skip="[^ ]}\|!." end="\%(^\| \)}"
  \ contains=
  \   chktexrcComment,
  \   chktexrcEscapeSequence,
  \   chktexrcPCREComment,
  \   chktexrcString
  \ nextgroup=chktexrcCaseInsensitiveList
  \ skipempty skipwhite

syn region chktexrcCaseInsensitiveList fold
  \ matchgroup=chktexrcOperator
  \ start="\[" skip="[^ ]\]\|!." end="\%(^\| \)\]"
  \ contains=
  \   chktexrcComment,
  \   chktexrcEscapeSequence,
  \   chktexrcPCREComment,
  \   chktexrcString
  \ nextgroup=chktexrcCaseSensitiveList
  \ skipempty skipwhite

syn match chktexrcEqualsSign display '\%(!!\)*!\@<!='
  \ nextgroup=
  \   chktexrcCaseInsensitiveList,
  \   chktexrcCaseSensitiveList,
  \   chktexrcNumber,
  \   chktexrcQuoteStyle,
  \   chktexrcCmdSpaceStyle,
  \   chktexrcString
  \ skipempty skipwhite

hi def link chktexrcNumber Number
hi def link chktexrcEscapeSequence PreProc
hi def link chktexrcFormatSpecifier Special
hi def link chktexrcString String
hi def link chktexrcPCREComment String
hi def link chktexrcTodo Todo
hi def link chktexrcComment Comment
hi def link chktexrcQuoteStyle Constant
hi def link chktexrcCmdSpaceStyle Constant
hi def link chktexrcKeyword Type
hi def link chktexrcEqualsSign chktexrcOperator
hi def link chktexrcOperator Operator

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = 'chktexrc'
