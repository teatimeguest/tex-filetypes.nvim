vim.bo.include = require("tex-filetypes.include.tex").include
vim.bo.includeexpr =
  [[v:lua.require'tex-filetypes.include.tex'.includeexpr(v:fname)]]
