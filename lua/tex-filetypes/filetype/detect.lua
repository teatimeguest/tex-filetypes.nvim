local M = {}

---@param path string
---@return boolean
local function ignored(path)
  if type(vim.g.ft_ignore_pat) == "string" then
    return vim.regex(vim.g.ft_ignore_pat):match_str(path) and true or false
  end
  return false
end

---@param bufnr integer
---@param opts? { start?: integer, limit?: integer }
---@return
---| fun(list: string[]): integer, string
---| fun(list: string[]): nil, nil
---@return string[]
local function lines(bufnr, opts)
  opts = vim.tbl_extend("force", { start = 1, limit = 20 }, opts or {})
  local start = opts.start - 1
  local end_ = opts.limit < 0 and opts.limit or (start + opts.limit)
  local index = 0
  return function(list)
    index = index + 1
    local line = list[index]
    if line then
      return start + index, line
    end
  end,
    vim.api.nvim_buf_get_lines(bufnr, start, end_, false)
end

---@overload fun(bufnr: integer, opts?: table): integer, string
---@overload fun(bufnr: integer, opts?: table): nil, nil
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
local function under_texmf_tree(path)
  return path:match("/texmf[/-]")
end

---@type vim.filetype.mapfn
function M.cfg()
  return vim.g.filetype_cfg or "tex"
end

---@type vim.filetype.mapfn
function M.def()
  return vim.g.filetype_def or "tex"
end

---@type vim.filetype.mapfn
function M.ini(path, bufnr)
  if not ignored(path) then
    local lnum = first_nonblank_line(bufnr)
    if lnum then
      if first_lines_match(bufnr, "^%s*[%%\\]", { start = lnum }) then
        return "tex"
      else
        return
      end
    end
  end
  if under_texmf_tree(path) then
    return "tex"
  end
end

---@type vim.filetype.mapfn
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
function M.profile(path, bufnr)
  if not ignored(path) then
    local lnum, line = first_nonblank_line(bufnr)
    if
      (lnum == 1 and line and line:find("texlive%.profile") ~= nil)
      or first_lines_match(bufnr, PROFILE_LINE_PATTERNS, { start = lnum })
    then
      return "texliveprofile"
    end
  end
end

return M
