if exists('b:did_ftplugin')
  finish
endif

setlocal comments=:#
setlocal commentstring=#\ %s

let b:undo_ftplugin = 'setlocal comments< commentstring<'
let b:did_ftplugin = 1
