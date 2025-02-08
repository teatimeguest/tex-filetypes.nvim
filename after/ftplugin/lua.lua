if not vim.b.did_ftplugin then
  return
end

local tex_filetypes = require("tex-filetypes")

if vim.b.is_texlua == nil then
  vim.b.is_texlua = tex_filetypes.dialect.is_texlua({ buf = 0 })
  vim.b.undo_ftplugin =
    table.concat({ vim.b.undo_ftplugin, "unlet! b:is_texlua" }, " | ")
end

vim.bo.includeexpr = tex_filetypes.includeexpr.lua .. vim.opt.includeexpr:get()

vim.b.undo_ftplugin =
  table.concat({ vim.b.undo_ftplugin, "setlocal includeexpr<" }, " | ")
