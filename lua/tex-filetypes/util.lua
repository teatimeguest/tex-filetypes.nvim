local M = {}

---@alias tex_filetypes.Iterator<T, U> fun(): T?, U?

local Iterator = {}

---@generic T
---@return tex_filetypes.Iterator<T>
function Iterator.empty()
  return function() end
end

M.Iterator = Iterator

local regex = {}

---Returns the first match for a given pattern in a row
---@param re vim.regex
---@param bufnr integer
---@param row integer 0-based
---@param start_col? integer 0-based
---@param end_col? integer 0-based end-exclusive
---@return Range2? range 0-based end-exclusive
---@nodiscard
function regex.match_line(re, bufnr, row, start_col, end_col)
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
function regex.gmatch_line(re, bufnr, row, start_col, end_col)
  ---@type Range2?
  local match = { 0, start_col or 0 }
  return function()
    if match then
      match = regex.match_line(re, bufnr, row, match[2], end_col)
      return match
    end
  end
end

M.regex = regex

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

---@param input string
---@param substring string plain substring
---@param offset? integer
---@return tex_filetypes.Iterator<Range2>
---@nodiscard
function M.find_all(input, substring, offset)
  offset = offset or 0
  return function()
    if offset then
      local end_col
      offset, end_col = input:find(substring, offset + 1, true)
      if offset then
        return { offset - 1, end_col }
      end
    end
  end
end

return M
