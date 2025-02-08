" See "2.2 Font Dictionary" of
" <https://adobe-type-tools.github.io/font-tech-notes/pdfs/T1_SPEC.pdf>:
syn region postscrBinary
  \ matchgroup=postscrOperator start="\<eexec\>"
  \ matchgroup=postscrOperator end="\<cleartomark\>"
  \ contains=NONE

hi def link postscrBinary NonText
