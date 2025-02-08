if not vim.b.did_ftplugin then
  return
end

local tex_filetypes = require("tex-filetypes")

vim.bo.include = tex_filetypes.include.tex
vim.bo.includeexpr = tostring(tex_filetypes.includeexpr.tex)

vim.b.undo_ftplugin =
  table.concat({ vim.b.undo_ftplugin, "setlocal include< includeexpr<" }, " | ")

if vim.g.loaded_matchit then
  vim.b.match_words = tex_filetypes.match_words.tex .. vim.b.match_words
  vim.b.undo_ftplugin =
    table.concat({ vim.b.undo_ftplugin, "unlet! b:match_words" }, " | ")
end
