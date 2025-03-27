local include = require("tex-filetypes.include")
local iter = require("tex-filetypes.util.iter")
local kpse = require("tex-filetypes.util.kpse")

local M = {}

---@type tex_filetypes.include.tex.Commands
local COMMANDS = vim
  .iter(require("tex-filetypes.include.tex.packages"))
  :fold(vim.empty_dict(), function(patterns, _, value)
    return vim.tbl_extend("error", patterns, value)
  end)

setmetatable(COMMANDS, {
  __index = function(self, key)
    for _, suffix in ipairs({ "TF", "T", "F" }) do
      if vim.endswith(key, suffix) then
        local value = rawget(self, key:sub(1, -#suffix - 1))
        if value then
          return value
        end
      end
    end
  end,
})

M.include = [[\\\%(]]
  .. vim
    .iter(vim.spairs(COMMANDS))
    :map(function(key, value)
      return key .. (value.TF and [[T\?F\?]] or "")
    end)
    :join([[\|]])
  .. [[\)\>]]

local RE = vim.regex(M.include)

---@param basename string
---@param config tex_filetypes.include.tex.Config
---@return string[]
---@nodiscard
local function get_filenames(basename, config)
  if type(config.pattern) == "function" then
    return config.pattern(basename)
  elseif config.pattern then
    return vim
      .iter(config.pattern)
      :map(function(pat)
        return pat:format(basename)
      end)
      :totable()
  elseif config.suffixes then
    return vim
      .iter(config.suffixes)
      :map(function(suffix)
        return basename .. suffix
      end)
      :totable()
  end
  return { basename }
end

---@param name string
---@param options? tex_filetypes.includeexpr.Options
---@return tex_filetypes.Iterator<string>
---@nodiscard
function M.resolve(name, options)
  if #name == 0 then
    return iter.empty()
  end
  options = vim.tbl_extend("force", {
    max_lines = include.DEFAULT_MAX_LINES,
    timeout_ms = include.DEFAULT_TIMEOUT_MS,
  }, options or {})
  local winnr = 0
  local cursor = vim.api.nvim_win_get_cursor(winnr)
  ---@type string[]
  local filenames = {}
  local command = include.get_include_directive(RE, cursor, options.max_lines)
  command = command and command:sub(2) --[[ Trim `\` ]]
  local config = command and COMMANDS[command] or {}
  if not command then
    filenames = { name }
  else
    if config.list then
      local item = include.get_item_under_cursor(name, cursor)
      if item then
        filenames = get_filenames(item, config)
      end
    end
    vim.list_extend(filenames, get_filenames(name, config))
  end
  return kpse.lookup(
    filenames,
    vim.tbl_extend("keep", {
      format = config.format,
      progname = config.progname,
    }, options)
  )
end

---@param fname? string
---@param options? tex_filetypes.includeexpr.Options
---@return string?
---@nodiscard
function M.includeexpr(fname, options)
  fname = fname or vim.v.fname
  return fname and M.resolve(fname, options)()
end

return M
