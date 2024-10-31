local M = {}

---@package
---@type table<string, vim.regex>
M._cache = vim.defaulttable(vim.regex)

---Create a `vim.regex` instance.
---@param re string
---@return vim.regex
function M.new(re)
  return M._cache[re]
end

---Returns the first match for a given pattern in a row
---@param re vim.regex
---@param bufnr integer
---@param row integer 0-based
---@param start_col? integer 0-based
---@param end_col? integer 0-based end-exclusive
---@return Range2? range 0-based end-exclusive
---@nodiscard
function M.match_line(re, bufnr, row, start_col, end_col)
  ---@type integer?, integer?, integer
  local match_start, match_end, offset = nil, nil, start_col or 0
  if not end_col then
    match_start, match_end = re:match_line(bufnr, row, offset)
  elseif offset < end_col then
    match_start, match_end = re:match_line(bufnr, row, offset, end_col)
  end
  if match_start and match_end then
    return { match_start + offset, match_end + offset }
  end
end

---Generates all matches for a given pattern in a row
---@param re vim.regex
---@param bufnr integer
---@param row integer 0-based
---@param start_col? integer 0-based
---@param end_col? integer 0-based end-exclusive
---@return tex_filetypes.Iterator<Range2> ranges 0-based end-exclusive
---@nodiscard
function M.gmatch_line(re, bufnr, row, start_col, end_col)
  ---@type Range2?
  local match = { 0, start_col or 0 }
  return function()
    if match then
      match = M.match_line(re, bufnr, row, match[2], end_col)
      return match
    end
  end
end

return M
