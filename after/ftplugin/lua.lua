if not vim.b.did_ftplugin or vim.b.is_texlua ~= nil then
  return
end

local ft = require("tex-filetypes.filetype")

local bufnr = vim.api.nvim_get_current_buf()
vim.b.is_texlua = ft.dialect.is_texlua({ buf = bufnr })
ft.add_undo_ftplugin(bufnr, "unlet! b:is_texlua")
