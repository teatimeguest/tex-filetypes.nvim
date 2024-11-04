" Vim syntax file
" Language: TeX fontmap file
"
" Reference: <https://tug.org/fontname/html/Name-mapping-file.html#Name-mapping-file>

if exists('b:current_syntax')
  finish
endif

syn keyword fontmapTodo TODO FIXME XXX contained

syn region fontmapComment display
  \ start="^[ \t%*;#]" end="$"
  \ contains=fontmapTodo,@Spell
  \ keepend oneline

syn region fontmapMapLine display
  \ transparent
  \ start="^[^ \t%*;#]" end="$"
  \ contains=fontmapTfmName
  \ keepend oneline

syn match fontmapTfmName display
  \ +^[^ \t%*;#<"]\S*+
  \ skipwhite nextgroup=fontmapPostScriptName,@fontmapOption

syn match fontmapPostScriptName display
  \ contained
  \ +\s\zs[^ \t%*;#<"]\S*+
  \ skipwhite nextgroup=@fontmapOption

syn cluster fontmapOption
  \ contains=
  \   @fontmapDownloadFile,
  \   fontmapPostScript

syn cluster fontmapDownloadFile
  \ contains=
  \   fontmapDownloadHeaderFile,
  \   fontmapDownloadEncodingFile,
  \   fontmapDownloadFontFile

syn include @Postscr syntax/postscr.vim

syn region fontmapPostScript display
  \ contained
  \ matchgroup=fontmapString start=+\s\zs"+ end=+"+
  \ contains=@Postscr
  \ keepend oneline skipwhite nextgroup=@fontmapOption

syn match fontmapDownloadFontFile display
  \ contained
  \ "\s<\ze[^<[ \t]"
  \ nextgroup=fontmapFontFile

syn match fontmapDownloadEncodingFile display
  \ contained
  \ "\s<\[\ze[^<[ \t]"
  \ nextgroup=fontmapEncodingFile

syn match fontmapDownloadHeaderFile display
  \ contained
  \ "\s<\ze[^<[]"
  \ skipwhite nextgroup=fontmapHeaderFile

syn match fontmapHeaderFile display
  \ contained
  \ "[^ \t%*;#<"]\S*"
  \ skipwhite nextgroup=@fontmapOption

syn match fontmapFontFile display
  \ contained
  \ "[^ \t%*;#<"]\S*"
  \ skipwhite nextgroup=@fontmapOption

syn match fontmapEncodingFile display
  \ contained
  \ "[^ \t%*;#<"]\S*"
  \ skipwhite nextgroup=@fontmapOption

hi def link fontmapComment Comment

hi def link fontmapTfmName Type
hi def link fontmapPostScriptName Identifier

hi def link fontmapDownloadEncodingFile Delimiter
hi def link fontmapDownloadFontFile Delimiter
hi def link fontmapDownloadHeaderFile Delimiter

hi def link fontmapEncodingFile Include
hi def link fontmapFontFile Include
hi def link fontmapHeaderFile Include

hi def link fontmapPostScript String
hi def link fontmapString String

let b:current_syntax = 'fontmap'
