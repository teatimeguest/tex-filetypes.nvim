local LEVEL = {}

---@param level integer
---@return string | integer
function LEVEL.at(level)
  return level
end

LEVEL.unknown = -1
LEVEL.keep = "="

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

return LEVEL
