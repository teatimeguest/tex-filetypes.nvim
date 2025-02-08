local LEVEL = require("tex-filetypes.fold.level")

local M = {}

---@param line? string
---@return boolean
local function continues(line)
  return line and vim.endswith(line, "\\") or false
end

---@param line? string
---@return boolean
local function is_list_item(line)
  return line and line:find("^%s%S") and (line[2] ~= "#") or false
end

---@param line? string
---@return string?
local function get_key(line)
  return line and line:match("^%w+")
end

---@param lnum integer
---@return string?, string?, string?
local function get_context(lnum)
  ---@type string?, string?, string?
  local prev_line, line, next_line = unpack(
    vim.api.nvim_buf_get_lines(0, math.max(lnum - 2, 0), lnum + 1, false)
  )
  if lnum == 1 then
    prev_line, line, next_line = nil, prev_line, line
  end
  return prev_line, line, next_line
end

---@param lnum? integer
---@return string | integer
function M.foldexpr(lnum)
  lnum = lnum or vim.v.lnum
  if lnum and lnum > 0 then
    ---@type string?, string?, string?
    local prev_line, line, next_line = get_context(lnum)
    if line then
      if continues(prev_line) then
        return LEVEL.keep
      end
      local field = get_key(line)
      -- The `name` and `(src|run|doc|bin)(files|pattern)` fields
      -- start a new fold:
      if field == "name" then
        return LEVEL.starts(1)
      elseif
        field
        and (vim.endswith(field, "files") or vim.endswith(field, "pattern"))
      then
        return LEVEL.starts(2)
      end
      local next_field = continues(line) and nil or get_key(next_line)
      -- For other fields and list items,
      -- the next line determines whether or not to end the fold:
      if field then
        return LEVEL[next_field == "name" and "ends" or "at"](1)
      elseif is_list_item(line) then
        return LEVEL[next_field and "ends" or "at"](2)
      end
      -- For blank lines, the next line determines the fold level:
      if next_field == "name" then
        return LEVEL.at(0)
      elseif next_field then
        return LEVEL.at(1)
      elseif is_list_item(next_line) then
        return LEVEL.at(2)
      end
    end
  end
  return LEVEL.unknown
end

return M
