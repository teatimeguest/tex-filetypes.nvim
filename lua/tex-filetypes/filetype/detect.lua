local M = {}

---@param path string
---@return boolean
---@nodiscard
local function ignored(path)
  if type(vim.g.ft_ignore_pat) == "string" then
    return vim.regex(vim.g.ft_ignore_pat):match_str(path) and true or false
  end
  return false
end

---@param bufnr integer
---@param opts? { start?: integer, limit?: integer }
---@return
---| fun(): integer, string
---| fun(): nil, nil
---@nodiscard
local function lines(bufnr, opts)
  opts = vim.tbl_extend("force", { start = 1, limit = 20 }, opts or {})
  local start = opts.start - 1
  local end_ = opts.limit < 0 and opts.limit or (start + opts.limit)
  local list = vim.api.nvim_buf_get_lines(bufnr, start, end_, false)
  local index = 0
  return function()
    index = index + 1
    local line = list[index]
    if line then
      return start + index, line
    end
  end
end

---@overload fun(bufnr: integer, opts?: table): integer, string
---@overload fun(bufnr: integer, opts?: table): nil, nil
---@nodiscard
local function first_nonblank_line(bufnr, opts)
  for lnum, line in lines(bufnr, opts) do
    if not line:match("^%s*$") then
      return lnum, line
    end
  end
end

---@param bufnr integer
---@param patterns string | string[]
---@param opts? table
---@return boolean
---@nodiscard
local function first_lines_match(bufnr, patterns, opts)
  patterns = type(patterns) == "string" and { patterns } or patterns
  for _, line in lines(bufnr, opts) do
    if
      vim.iter(patterns):all(function(pattern)
        return not line:match(pattern)
      end)
    then
      return false
    end
  end
  return true
end

---@param path string
---@return boolean
---@nodiscard
local function under_texmf_tree(path)
  return path:match("/texmf[/-]")
end

---@type vim.filetype.mapfn
---@nodiscard
function M.cfg(path)
  return vim.g.filetype_cfg or (under_texmf_tree(path) and "tex" or nil)
end

---@type vim.filetype.mapfn
---@nodiscard
function M.def(path)
  return vim.g.filetype_def or (under_texmf_tree(path) and "tex" or nil)
end

---@type vim.filetype.mapfn
---@nodiscard
function M.ini(path, bufnr)
  if ignored(path) then
    if not under_texmf_tree(path) then
      return
    end
  else
    local lnum = first_nonblank_line(bufnr)
    if lnum then
      if not first_lines_match(bufnr, "^%s*[%%\\]", { start = lnum }) then
        return
      end
    end
  end
  return "tex"
end

---@type vim.filetype.mapfn
---@nodiscard
function M.pl(path, bufnr)
  if vim.g.filetype_pl then
    return vim.g.filetype_pl
  end
  if not ignored(path) then
    local _, line = first_nonblank_line(bufnr)
    if line and line:match("^%s*%(%s*[A-Z0-9]+") then
      return "propertylist"
    end
  end
end

---@type string[]
local PROFILE_LINE_PATTERNS = vim
  .iter({
    "$",
    "#",
    "TEX",
    "binary_",
    "collection%-",
    "in_place",
    "instopt_",
    "option_",
    "portable",
    "selected_",
    "tlpdbopt_",
  })
  :map(function(prefix)
    return "^%s*" .. prefix
  end)
  :totable()

---@type vim.filetype.mapfn
---@nodiscard
function M.profile(path, bufnr)
  if ignored(path) then
    if not under_texmf_tree(path) then
      return
    end
  else
    local lnum, line = first_nonblank_line(bufnr)
    if
      not (lnum == 1 and line and line:find("texlive%.profile"))
      and not first_lines_match(bufnr, PROFILE_LINE_PATTERNS, { start = lnum })
    then
      return
    end
  end
  return "texliveprofile"
end

---@class tex_filetypes.filetype.detect.is_texlua.Options
---@field max_lines? integer [default: 200]

---@param target vim.filetype.match.args
---@param options? tex_filetypes.filetype.detect.is_texlua.Options
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
  local pattern = vim.regex([[\<\%(tex\%(io\|config\)\|kpse\|luaharfbuzz\)\.]])
  for row, line in ipairs(contents or {}) do
    if
      row == 1
      and vim.regex([[^#!.\{-}\<\%(texlua\|luatex\)\>]]):match_str(line)
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
