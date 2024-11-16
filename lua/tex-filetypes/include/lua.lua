local dialect = require("tex-filetypes.filetype.dialect")
local kpse = require("tex-filetypes.util.kpse")

local M = {}

---@param fname string
---@param options? tex_filetypes.includeexpr.Options
---@return tex_filetypes.Iterator<string>
---@nodiscard
function M.resolve(fname, options)
  options = vim.tbl_extend(
    "force",
    { timeout_ms = M.DEFAULT_TIMEOUT_MS },
    options or {},
    { format = "lua" }
  )
  return kpse.lookup({ fname }, options)
end

---@param fname string
---@param options? tex_filetypes.includeexpr.Options
---@return string?
---@nodiscard
function M.includeexpr(fname, options)
  local bufnr = vim.api.nvim_get_current_buf()
  if dialect.is_texlua({ buf = bufnr }) then
    return M.resolve(fname, options)()
  end
end

return M
