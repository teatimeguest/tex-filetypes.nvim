local regex = require("tex-filetypes.util.regex")

local M = {}

---@class tex_filetypes.filetype.dialect.is_texlua.Options
---@field max_lines? integer [default: 200]

---@param target vim.filetype.match.args
---@param options? tex_filetypes.filetype.dialect.is_texlua.Options
---@return boolean
---@nodiscard
function M.is_texlua(target, options)
  local bufnr = (target.buf and vim.api.nvim_buf_is_valid(target.buf) or nil)
    and target.buf
  local filename = target.filename
    or (bufnr and vim.api.nvim_buf_get_name(bufnr))
  if
    filename
    and (
      vim.endswith(filename, ".luatex")
      or vim.endswith(filename, ".texlua")
      or vim.endswith(filename, ".tlu")
    )
  then
    return true
  end
  local max_lines = options and options.max_lines or 200
  local contents = target.contents
    or (bufnr and vim.api.nvim_buf_get_lines(bufnr, 0, max_lines, false))
  local pattern = regex.new([[\<\%(tex\%(io\|config\)\|kpse\|luaharfbuzz\)\.]])
  for row, line in ipairs(contents or {}) do
    if
      row == 1
      and regex.new([[^#!.\{-}\<\%(texlua\|luatex\)\>]]):match_str(line)
    then
      return true
    end
    if pattern:match_str(line) then
      return true
    end
  end
  return false
end

return M
