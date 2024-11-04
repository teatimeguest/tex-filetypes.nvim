local M = {}

---@param input string
---@param substring string substring
---@param offset? integer 0-based
---@return tex_filetypes.Iterator<Range2>
---@nodiscard
function M.find_all_substrings(input, substring, offset)
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

---@class tex_filetypes.util.pattern.find_any.Options
---@field offset? integer 0-based
---@field plain? boolean

---@param input string
---@param pattern string[]
---@param options? tex_filetypes.util.pattern.find_any.Options
---@return Range2?
---@return string? ... captures
---@nodiscard
function M.find(input, pattern, options)
  local offset = options and options.offset or 0
  local plain = options and options.plain
  for _, pat in ipairs(pattern) do
    local match = { input:find(pat, offset + 1, plain) }
    if match[1] then
      return { match[1], match[2] }, unpack(match --[[@as string[] ]], 3)
    end
  end
end

return M
