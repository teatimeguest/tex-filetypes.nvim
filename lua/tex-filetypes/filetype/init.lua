local M = {}

M.detect = require("tex-filetypes.filetype.detect")
M.dialect = require("tex-filetypes.filetype.dialect")

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

---@param bufnr integer
---@param undo_ftplugin string
function M.add_undo_ftplugin(bufnr, undo_ftplugin)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  local b_undo_ftplugin = vim.b[bufnr].undo_ftplugin
  if b_undo_ftplugin then
    vim.b[bufnr].undo_ftplugin = b_undo_ftplugin .. " | " .. undo_ftplugin
  else
    vim.b[bufnr].undo_ftplugin = undo_ftplugin
  end
end

return M
