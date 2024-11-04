if vim.b.did_ftplugin then
  return
end

vim.opt_local.comments = { ":\\ ", ":%", ":*", ":;", ":#" }
vim.bo.commentstring = [[%\ %s]]

vim.bo.include = [[\s<\%([<[]\|\s*\)]]
vim.bo.includeexpr =
  [[v:lua.require'tex-filetypes.include'.includeexpr(v:fname)]]

vim.b.undo_ftplugin = "setlocal comments< commentstring< include< includeexpr<"
vim.b.did_ftplugin = 1
