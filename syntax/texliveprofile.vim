" Vim syntax file
" Language: TeX Live installation profile
" Version: 2024
"
" See <https://www.tug.org/texlive/doc/install-tl.html#PROFILES>

if exists('b:current_syntax')
  finish
endif

syn iskeyword @,-,48-57,_,192-255

syn keyword texliveProfileBoolean 0 1
  \ contained
  \ skipwhite
  \ nextgroup=
  \   texliveProfileComment,
  \   texliveProfileInvalidArgument

syn keyword texliveProfileTodo TODO FIXME XXX contained

syn region texliveProfileComment
  \ display
  \ start='\s*#' end='$'
  \ contains=texliveProfileTodo,@Spell
  \ keepend oneline

syn region texliveProfileInvalidOption
  \ display
  \ start='\<[^[:space:]#]\+[[:space:]#]' end='$'
  \ contains=texliveProfileComment
  \ keepend oneline

syn region texliveProfileInvalidArgument
  \ display
  \ contained
  \ start='\S' end='$'
  \ contains=texliveProfileComment
  \ keepend oneline

syn region texliveProfileMissingArgument
  \ display
  \ contained
  \ start='#' end='$'
  \ keepend oneline

syn keyword texliveProfileSchemeOption selected_scheme
  \ skipwhite
  \ nextgroup=
  \   texliveProfileScheme,
  \   texliveProfileMissingArgument

syn match texliveProfileScheme
  \ display
  \ contained
  \ '\<\K\k*\>'
  \ skipwhite
  \ nextgroup=
  \   texliveProfileComment,
  \   texliveProfileInvalidArgument

syn match texliveProfileCollection
  \ display
  \ '\<collection-\k\+\>'
  \ skipwhite
  \ nextgroup=
  \   texliveProfileComment,
  \   texliveProfileInvalidArgument

syn keyword texliveProfilePathOption
  \ TEXDIR
  \ TEXMFLOCAL
  \ TEXMFSYSCONFIG
  \ TEXMFSYSVAR
  \ TEXMFCONFIG
  \ TEXMFVAR
  \ TEXMFHOME
  \ skipwhite
  \ nextgroup=
  \   texliveProfilePath,
  \   texliveProfileMissingArgument

syn region texliveProfilePath
  \ display
  \ contained
  \ start='[^[:space:]#]' end='$'
  \ contains=texliveProfileComment
  \ keepend oneline

syn match texliveProfilePlatformOption
  \ display
  \ '\<binary_\k\+\>'
  \ skipwhite
  \ nextgroup=
  \   texliveProfileBoolean,
  \   texliveProfileMissingArgument,
  \   texliveProfileInvalidArgument

syn keyword texliveProfileInstallerOption
  \ instopt_adjustpath
  \ instopt_adjustrepo
  \ instopt_letter
  \ instopt_portable
  \ instopt_write18_restricted
  \ skipwhite
  \ nextgroup=
  \   texliveProfileBoolean,
  \   texliveProfileMissingArgument,
  \   texliveProfileInvalidArgument

syn keyword texliveProfileTlpdbOption
  \ tlpdbopt_create_formats
  \ tlpdbopt_generate_updmap
  \ tlpdbopt_install_docfiles
  \ tlpdbopt_install_srcfiles
  \ tlpdbopt_post_code
  \ skipwhite
  \ nextgroup=
  \   texliveProfileBoolean,
  \   texliveProfileMissingArgument,
  \   texliveProfileInvalidArgument

syn keyword texliveProfileTlpdbOption tlpdbopt_autobackup
  \ skipwhite
  \ nextgroup=
  \   texliveProfileNumberOfBackups,
  \   texliveProfileMissingArgument,
  \   texliveProfileInvalidArgument

syn match texliveProfileNumberOfBackups
  \ display
  \ contained
  \ '\<\%(-1\|\d\+\)\>'
  \ skipwhite
  \ nextgroup=
  \   texliveProfileComment,
  \   texliveProfileInvalidArgument

syn keyword texliveProfileTlpdbOption
  \ tlpdbopt_backupdir
  \ tlpdbopt_sys_bin
  \ tlpdbopt_sys_info
  \ tlpdbopt_sys_man
  \ skipwhite
  \ nextgroup=
  \   texliveProfilePath,
  \   texliveProfileMissingArgument

if !get(g:, 'texlive_profile_disable_windows_only_options', 0)
  syn keyword texliveProfileTlpdbOption
    \ tlpdbopt_desktop_integration
    \ tlpdbopt_w32_multi_user
    \ skipwhite
    \ nextgroup=
    \   texliveProfileBoolean,
    \   texliveProfileMissingArgument,
    \   texliveProfileInvalidArgument

  syn keyword texliveProfileTlpdbOption tlpdbopt_file_assocs
    \ skipwhite
    \ nextgroup=
    \   texliveProfileFileassocMode,
    \   texliveProfileMissingArgument,
    \   texliveProfileInvalidArgument

  syn keyword texliveProfileFileassocMode 0 1 2
    \ contained
    \ skipwhite
    \ nextgroup=
    \   texliveProfileComment,
    \   texliveProfileInvalidArgument
endif

if !get(g:, 'texlive_profile_disable_legacy_options', 0)
  syn keyword texliveProfileLegacyOption
    \ option_doc
    \ option_fmt
    \ option_src
    \ option_post_code
    \ option_adjustrepo
    \ option_letter
    \ option_path
    \ option_symlinks
    \ portable
    \ option_write18_restricted
    \ skipwhite
    \ nextgroup=
    \   texliveProfileBoolean,
    \   texliveProfileMissingArgument,
    \   texliveProfileInvalidArgument

  syn keyword texliveProfileLegacyOption option_autobackup
    \ skipwhite
    \ nextgroup=
    \   texliveProfileNumberOfBackups,
    \   texliveProfileMissingArgument,
    \   texliveProfileInvalidArgument

  syn keyword texliveProfileLegacyOption
    \ option_backupdir
    \ option_sys_bin
    \ option_sys_info
    \ option_sys_man
    \ skipwhite
    \ nextgroup=
    \   texliveProfilePath,
    \   texliveProfileMissingArgument

  if !get(g:, 'texlive_profile_disable_ignored_optinos', 0)
    syn keyword texliveProfileIgnoredOption in_place
      \ skipwhite
      \ nextgroup=
      \   texliveProfileBoolean,
      \   texliveProfileMissingArgument,
      \   texliveProfileInvalidArgument
  endif

  if !get(g:, 'texlive_profile_disable_windows_only_options', 0)
    syn keyword texliveProfileLegacyOption
      \ option_desktop_integration
      \ option_w32_multi_user
      \ skipwhite
      \ nextgroup=
      \   texliveProfileBoolean,
      \   texliveProfileMissingArgument,
      \   texliveProfileInvalidArgument

    syn keyword texliveProfileLegacyOption option_file_assocs
      \ skipwhite
      \ nextgroup=
      \   texliveProfileFileassocMode,
      \   texliveProfileMissingArgument,
      \   texliveProfileInvalidArgument

    if !get(g:, 'texlive_profile_disable_ignored_optinos', 0)
      syn keyword texliveProfileIgnoredOption option_menu_integration
        \ skipwhite
        \ nextgroup=
        \   texliveProfileBoolean,
        \   texliveProfileMissingArgument,
        \   texliveProfileInvalidArgument
    endif
  endif
endif

hi def link texliveProfileInvalidOption texliveProfileError
hi def link texliveProfileMissingArgument texliveProfileError
hi def link texliveProfileInvalidArgument texliveProfileError

hi def link texliveProfileSchemeOption texliveProfileOption
hi def link texliveProfileInstallerOption texliveProfileOption
hi def link texliveProfileTlpdbOption texliveProfileOption
hi def link texliveProfileLegacyOption texliveProfileOption

hi def link texliveProfileBoolean Boolean
hi def link texliveProfileTodo Todo
hi def link texliveProfileComment Comment
hi def link texliveProfileError Error
hi def link texliveProfileScheme Type
hi def link texliveProfileCollection Type
hi def link texliveProfilePath String
hi def link texliveProfileNumberOfBackups Number
hi def link texliveProfileFileassocMode Constant
hi def link texliveProfileOption Statement
hi def link texliveProfilePathOption Define
hi def link texliveProfilePlatformOption Identifier
hi def link texliveProfileIgnoredOption DiagnosticDeprecated

let b:current_syntax = 'texliveprofile'
