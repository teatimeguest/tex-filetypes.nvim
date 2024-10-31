local M = {}

function M.setup()
  vim.filetype.add(require("tex-filetypes.filetype").filetypes)
end

return M
