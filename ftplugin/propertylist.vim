if exists('b:did_ftplugin')
  finish
endif

setlocal comments=sb:(COMMENT,m:\ ,ex:)
setlocal commentstring=(COMMENT\ %s)
setlocal foldmethod=syntax

let b:undo_ftplugin = 'setlocal comments< commentstring< foldmethod<'
let b:did_ftplugin = 1
