local I = require("tex-filetypes.include")
local Iterator = require("tex-filetypes.util").Iterator

local M = {}

---@type tex_filetypes.include.tex.Commands
local COMMANDS = vim
  .iter(require("tex-filetypes.include.tex.packages"))
  :fold(vim.empty_dict(), function(patterns, _, value)
    return vim.tbl_extend("error", patterns, value)
  end)

M.include = [[\\\%(]]
  .. vim
    .iter(vim.spairs(COMMANDS))
    :map(function(key)
      return key
    end)
    :join([[\|]])
  .. [[\)\>]]

local RE = vim.regex(M.include)

---@param name string
---@param config tex_filetypes.include.tex.Config
---@return string[]
---@nodiscard
local function get_patterns(name, config)
  if type(config.pattern) == "function" then
    return config.pattern(name)
  elseif config.pattern then
    return vim
      .iter(config.pattern)
      :map(function(pat)
        return pat:format(name)
      end)
      :totable()
  elseif config.suffixes then
    return vim
      .iter(config.suffixes)
      :map(function(suffix)
        return name .. suffix
      end)
      :totable()
  end
  return { name }
end

---@param name string
---@param options? tex_filetypes.includeexpr.Options
---@return tex_filetypes.Iterator<string>
---@nodiscard
function M.resolve(name, options)
  if #name == 0 then
    return Iterator.empty()
  end
  options = vim.tbl_extend("force", {
    max_lines = I.DEFAULT_MAX_LINES,
    timeout_ms = I.DEFAULT_TIMEOUT_MS,
  }, options or {})
  local winnr = 0
  local cursor = vim.api.nvim_win_get_cursor(winnr)
  local command = I.get_include_directive(RE, cursor, options.max_lines)
  if not command then
    return Iterator.empty()
  end
  local config = COMMANDS[command:sub(2)] --[[ Trim `\` ]]
  ---@type string[]
  local patterns = {}
  if config.list then
    local item = I.get_item_under_cursor(name, cursor)
    if item then
      patterns = get_patterns(item, config)
    end
  end
  vim.list_extend(patterns, get_patterns(name, config))
  return I.kpsewhich(
    patterns,
    vim.tbl_extend("keep", {
      format = config.format,
      progname = config.progname,
    }, options)
  )
end

---@param fname string
---@param options tex_filetypes.includeexpr.Options
---@return string?
---@nodiscard
function M.includeexpr(fname, options)
  return M.resolve(fname, options)()
end

return M
