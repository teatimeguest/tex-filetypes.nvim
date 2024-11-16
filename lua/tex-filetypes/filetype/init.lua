local M = {}

M.filetypes = vim.iter(require("tex-filetypes.filetype.packages")):fold(
  {} --[[@as vim.filetype.add.filetypes]],
  ---@param value vim.filetype.add.filetypes
  function(filetypes, _, value)
    for _, key in ipairs({ "extension", "filename", "pattern" }) do
      filetypes[key] =
        vim.tbl_extend("error", filetypes[key] or {}, value[key] or {})
    end
    return filetypes
  end
)

function M.setup()
  vim.filetype.add(M.filetypes)
end

return M
