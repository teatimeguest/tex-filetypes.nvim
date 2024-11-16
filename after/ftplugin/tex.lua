if not vim.b.did_ftplugin then
  return
end

vim.bo.include = require("tex-filetypes.include.tex").include
vim.bo.includeexpr =
  [[v:lua.require'tex-filetypes.include.tex'.includeexpr(v:fname)]]

vim.b.undo_ftplugin =
  table.concat({ vim.b.undo_ftplugin, "setlocal include< includeexpr<" }, " | ")

if vim.g.loaded_matchit then
  vim.b.match_words = table.concat({
    vim
      .iter(require("tex-filetypes.match.tex"))
      :map(function(item)
        return table.concat(item, ":")
      end)
      :join(","),
    vim.b.match_words,
  }, ",")

  vim.b.undo_ftplugin =
    table.concat({ vim.b.undo_ftplugin, "unlet! b:match_words" }, " | ")
end
