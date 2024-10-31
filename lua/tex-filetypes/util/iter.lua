---@alias tex_filetypes.Iterator<T, U> fun(): T?, U?

local M = {}

---@generic T
---@return tex_filetypes.Iterator<T>
function M.empty()
  return function() end
end

return M
