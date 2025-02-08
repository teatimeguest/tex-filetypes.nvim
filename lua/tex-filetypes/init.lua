local M = {}

---@class tex_filetypes.Expr
---@operator concat(string?): string

---@class tex_filetypes.Foldexpr: tex_filetypes.Expr
---@overload fun(lnum?: integer): string | integer
---@nodiscard

---@class tex_filetypes.Includeexpr: tex_filetypes.Expr
---@overload fun(
---  fname: string,
---  options?: tex_filetypes.includeexpr.Options,
---): string?
---@nodiscard

---@type metatable
local Expr = {}

---@param expr? string
---@return string
function Expr:__concat(expr)
  return table.concat({ tostring(self), expr }, " ?? ")
end

---@return tex_filetypes.Expr
---@overload fun(
---  option: "foldexpr",
---  ft: string,
---  fn: fun(lnum?: integer): (string | integer),
---): tex_filetypes.Foldexpr
---@overload fun(
---  option: "includeexpr",
---  ft: string,
---  fn: fun(
---    fname: string,
---    options?: tex_filetypes.includeexpr.Options,
---  ): (string?),
---): tex_filetypes.Includeexpr
---@nodiscard
local function create_expr(option, ft, fn)
  local expr = ([[v:lua.require'tex-filetypes'.%s.%s()]]):format(option, ft)
  return setmetatable({}, {
    __call = function(_, ...)
      return fn(...)
    end,
    __concat = Expr.__concat,
    __tostring = function()
      return expr
    end,
  })
end

---@type vim.filetype.add.filetypes
M.filetypes = vim.iter(require("tex-filetypes.filetype.filetypes")):fold(
  {} --[[@as vim.filetype.add.filetypes]],
  ---@param filetype vim.filetype.add.filetypes
  function(filetypes, _, filetype)
    for _, key in ipairs({ "extension", "filename", "pattern" }) do
      filetypes[key] =
        vim.tbl_extend("error", filetypes[key] or {}, filetype[key] or {})
    end
    return filetypes
  end
)

M.detect = require("tex-filetypes.filetype.detect")

M.dialect = require("tex-filetypes.filetype.dialect")

---@class tex_filetypes.foldexpr
---@field tlpdb tex_filetypes.Foldexpr
M.foldexpr = vim.defaulttable(
  ---@param ft unknown
  function(ft)
    if ft == "tlpdb" then
      return create_expr(
        "foldexpr",
        ft,
        require("tex-filetypes.fold.tlpdb").foldexpr
      )
    end
  end
)

---@class tex_filetypes.include
---@field tex string
M.include = vim.defaulttable(
  ---@param ft unknown
  ---@return string?
  function(ft)
    if ft == "tex" then
      return require("tex-filetypes.include.tex").include
    end
  end
)

---@class tex_filetypes.includeexpr
---@field [string] tex_filetypes.Includeexpr
M.includeexpr = vim.defaulttable(
  ---@param ft unknown
  function(ft)
    local fn
    if ft == "lua" then
      fn = require("tex-filetypes.include.lua").includeexpr
    elseif ft == "tex" then
      fn = require("tex-filetypes.include.tex").includeexpr
    elseif type(ft) == "string" then
      fn = require("tex-filetypes.include").includeexpr
    end
    return fn and create_expr("includeexpr", ft, fn)
  end
)

---@class tex_filetypes.MatchWords
---@field [1] string
---@field [2] string
---@field [3]? string
---@operator concat(string?): string

---@type metatable
local MatchWords = {}

---@return string
function MatchWords:__tostring()
  return vim
    .iter(self)
    :map(
      ---@param item [string, string, string?]
      ---@return string
      function(item)
        return table.concat(item, ":")
      end
    )
    :join(",")
end

---@param item string?
---@return string
function MatchWords:__concat(item)
  return table.concat({ tostring(self), item })
end

---@param match_words [string, string, string?][]
---@return tex_filetypes.MatchWords
local function create_match_words(match_words)
  return setmetatable(match_words, MatchWords)
end

---@class tex_filetypes.match_words
---@field tex tex_filetypes.MatchWords
M.match_words = vim.defaulttable(
  ---@param ft unknown
  function(ft)
    if ft == "tex" then
      return create_match_words(require("tex-filetypes.match.tex").match_words)
    end
  end
)

---@return nil
function M.setup()
  vim.filetype.add(M.filetypes)
end

return M
