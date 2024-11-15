local M = {}

local LEVEL = {}

---@param line string
---@return boolean
local function continues(line)
  return vim.endswith(line, "\\")
end

---@param line string
---@return boolean
local function has_list_item(line)
  return line:find("^%s%S") and (line[2] ~= "#") or false
end

---@param line string
---@return string?
local function get_key(line)
  return line:match("^%w+")
end

---@param lnum integer
---@return string | integer
function M.foldexpr(lnum)
  ---@type string?, string?, string?
  local prev_line, line, next_line = unpack(
    vim.api.nvim_buf_get_lines(0, math.max(lnum - 2, 0), lnum + 1, false)
  )
  if lnum == 1 then
    prev_line, line, next_line = nil, prev_line, line
  end
  if not line then
    return LEVEL.unknown()
  end
  if prev_line and continues(prev_line) then
    return LEVEL.keep()
  end
  local field = get_key(line)
  -- The `name` and `(src|run|doc|bin)(files|pattern)` fields start a new fold:
  if field == "name" then
    return LEVEL.starts(1)
  elseif
    field and (vim.endswith(field, "files") or vim.endswith(field, "pattern"))
  then
    return LEVEL.starts(2)
  end
  local next_field = continues(line) and nil
    or (next_line and next_line:match("^%w+"))
  -- For other fields and list items,
  -- the next line determines whether or not to end the fold:
  if field then
    return LEVEL[next_field == "name" and "ends" or "at"](1)
  elseif has_list_item(line) then
    return LEVEL[next_field and "ends" or "at"](2)
  end
  -- For blank lines, the next line determines the fold level:
  if next_field == "name" then
    return LEVEL.at(0)
  elseif next_field then
    return LEVEL.at(1)
  elseif next_line and has_list_item(next_line) then
    return LEVEL.at(2)
  end
  return LEVEL.unknown()
end

---@param level integer
---@return string | integer
function LEVEL.at(level)
  return level
end

---@return string | integer
function LEVEL.unknown()
  return -1
end

---@return string
function LEVEL.keep()
  return "="
end

---@param step integer
---@return string
function LEVEL.increase(step)
  return "a" .. tostring(step)
end

---@param step integer
---@return string
function LEVEL.decrease(step)
  return "s" .. tostring(step)
end

---@param level integer
---@return string
function LEVEL.starts(level)
  return ">" .. tostring(level)
end

---@param level integer
---@return string
function LEVEL.ends(level)
  return "<" .. tostring(level)
end

return M
