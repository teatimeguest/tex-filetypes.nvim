local regex = require("tex-filetypes.util.regex")

local M = {}

---@param re vim.regex
---@param bufnr integer
---@param start_row integer 0-based
---@param start_col integer 0-based
---@param max_lines? integer
---@return Range4?
---@nodiscard
function M.search_forward(re, bufnr, start_row, start_col, max_lines)
  if max_lines and (max_lines <= 0) then
    return
  end
  local lines = vim.api.nvim_buf_line_count(bufnr)
  max_lines = max_lines or lines
  for row = start_row, math.min(lines, start_row + max_lines) - 1 do
    local match = regex.match_line(re, bufnr, row, start_col)
    if match then
      return { row, match[1], row, match[2] }
    end
    start_col = 0
  end
end

---@param re vim.regex
---@param bufnr integer
---@param start_row integer 0-based
---@param start_col integer 0-based
---@param max_lines? integer
---@return Range4?
---@nodiscard
function M.search_backward(re, bufnr, start_row, start_col, max_lines)
  max_lines = max_lines or (start_row + 1)
  if max_lines <= 0 then
    return
  end
  ---@type integer?
  local end_col = start_col
  -- First search upward for the first row containing the pattern.
  for row = start_row, math.max(0, start_row - max_lines + 1), -1 do
    local match = regex.match_line(re, bufnr, row, 0, end_col)
    if match then
      -- Then look for the last match in the row.
      for m in regex.gmatch_line(re, bufnr, row, match[2], end_col) do
        match = m
      end
      return { row, match[1], row, match[2] }
    end
    end_col = nil
  end
end

return M
