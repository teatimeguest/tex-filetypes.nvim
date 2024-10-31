if vim.b.did_ftplugin then
  local ft = require("tex-filetypes.filetypes")
  vim.bo.include = require("tex-filetypes.include.tex").include
  vim.bo.includeexpr =
    [[v:lua.require'tex-filetypes.include.tex'.includeexpr(v:fname)]]
  ft.add_undo_plugin("setlocal include< includeexpr<")
end
