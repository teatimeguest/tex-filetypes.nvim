if vim.b.did_ftplugin then
  return
end

vim.bo.comments = ":#"
vim.bo.commentstring = [[#\ %s]]

vim.b.undo_ftplugin = "setlocal comments< commentstring<"
vim.b.did_ftplugin = 1
