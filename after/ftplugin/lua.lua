if not vim.b.did_ftplugin then
  return
end

local dialect = require("tex-filetypes.filetype.dialect")

local bufnr = vim.api.nvim_get_current_buf()

if vim.b.is_texlua == nil then
  vim.b.is_texlua = dialect.is_texlua({ buf = bufnr })
  vim.b.undo_ftplugin =
    table.concat({ vim.b.undo_ftplugin, "unlet! b:is_texlua" }, " | ")
end

vim.bo.includeexpr = table.concat({
  [[v:lua.require'tex-filetypes.include.lua'.includeexpr(v:fname)]],
  vim.opt.includeexpr:get(),
}, " ?? ")

vim.b.undo_ftplugin =
  table.concat({ vim.b.undo_ftplugin, "setlocal includeexpr<" }, " | ")
