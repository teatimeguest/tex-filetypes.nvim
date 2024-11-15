if vim.b.did_ftplugin then
  return
end

vim.bo.comments = ":#"
vim.bo.commentstring = [[#\ %s]]

vim.bo.define = [[\%([^\\]\r\?\n\|\%^\)name\>]]

vim.api.nvim_set_option_value("foldmethod", "expr", { scope = "local" })
vim.api.nvim_set_option_value(
  "foldexpr",
  [[v:lua.require'tex-filetypes.fold.tlpdb'.foldexpr(v:lnum)]],
  { scope = "local" }
)

vim.b.undo_ftplugin =
  "setlocal comments< commentstring< define< foldmethod< foldexpr<"
vim.b.did_ftplugin = 1
