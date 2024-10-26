local util = require("tex-filetypes.util")

local M = {}

---@class tex_filetypes.includeexpr.Options: tex_filetypes.kpsewhich.Options
---@field max_lines? integer

M.DEFAULT_MAX_LINES = 200
M.DEFAULT_TIMEOUT_MS = 1000 -- 1s

---@class tex_filetypes.kpsewhich.Options
---@field all? boolean
---@field format? string
---@field progname? string
---@field timeout_ms? integer

---@param filenames string[]
---@param options? tex_filetypes.kpsewhich.Options
---@return tex_filetypes.Iterator<string>
---@nodiscard
function M.kpsewhich(filenames, options)
  options = options or {}
  if #filenames > 0 then
    local cmd = { "kpsewhich" }
    if options.all then
      table.insert(cmd, "-all")
    end
    if options.format then
      vim.list_extend(cmd, { "-format", options.format })
    end
    if options.progname then
      vim.list_extend(cmd, { "-progname", options.progname })
    end
    ---@type vim.SystemObj?
    local process = vim.F.npcall(
      vim.system,
      vim.list_extend(cmd, { "--", unpack(filenames) }),
      { text = true, timeout = options.timeout_ms }
    )
    if process then
      local result = process:wait()
      if result.signal == 0 and result.stdout then
        return vim.gsplit(result.stdout, "\n", {
          plain = true,
          trimempty = true,
        })
      end
    end
  end
  return function() end
end

---@param include_re vim.regex
---@param cursor [integer, integer]?
---@param max_lines? integer
---@return string? directive
---@return Range4? location
---@nodiscard
function M.get_include_directive(include_re, cursor, max_lines)
  local winnr, bufnr = 0, 0
  local lnum, col = unpack(cursor or vim.api.nvim_win_get_cursor(winnr))
  local match =
    util.search_backward(include_re, bufnr, lnum - 1, col, max_lines)
  if match then
    local directive = vim.api.nvim_buf_get_text(
      bufnr,
      match[1],
      match[2],
      match[3],
      match[4],
      {}
    )[1]
    return directive, match
  end
end

---@param range Range2
---@param x integer
---@return boolean
---@nodiscard
local function contains(range, x)
  return range[1] <= x and x < range[2]
end

---@param fname string
---@param cursor [integer, integer]?
---@return string?
---@nodiscard
function M.get_item_under_cursor(fname, cursor)
  if not fname:find(",", nil, true) then
    return
  end
  local winnr, bufnr = 0, 0
  local lnum, col = unpack(cursor or vim.api.nvim_win_get_cursor(winnr))
  local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)[1]
  if not line then
    return
  end
  for range in util.find_all(line, fname) do
    if contains(range, col) then
      local offset = col - range[1]
      for start_col, item in
        fname:gmatch("()([^,]+)") --[[
          @as tex_filetypes.Iterator<integer, string>
        ]]
      do
        if contains({ start_col, start_col + #item }, offset + 1) then
          return item
        end
      end
      return
    end
  end
end

return M