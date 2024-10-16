local M = {}

function M.setup()
  for _, config in pairs(require("tex-filetypes.filetype")) do
    vim.filetype.add(config)
  end
end

return M
