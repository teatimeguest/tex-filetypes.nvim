local iter = require("tex-filetypes.util.iter")

local M = {}

---@class tex_filetypes.util.kpse.Options
---@field all? boolean
---@field format? string
---@field progname? string
---@field var_value? string
---@field cwd? string
---@field timeout_ms? integer

---@param options? tex_filetypes.util.kpse.Options
---@param filenames? string[]
---@return tex_filetypes.Iterator<string>
---@nodiscard
local function kpsewhich(options, filenames)
  options = options or {}
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
  if options.var_value then
    vim.list_extend(cmd, { "-var-value", options.var_value })
  end
  if filenames and #filenames > 0 then
    -- Emulates `luatex`'s behavior:
    -- (https://github.com/TeX-Live/luatex/blob/1.15.0/source/texk/web2c/luatexdir/lua/luainit.c#L646)
    if options.format == "lua" then
      filenames = vim
        .iter(filenames)
        :map(
          ---@param name string
          ---@return string[]
          function(name)
            if name:find(".", nil, true) then
              return { name:gsub([[\.]], "/"), name }
            else
              return { name }
            end
          end
        )
        :flatten()
        :totable()
    end
    vim.list_extend(cmd, { "--", unpack(filenames) })
  end
  ---@type vim.SystemObj?
  local process = vim.F.npcall(vim.system, cmd, {
    text = true,
    timeout = options.timeout_ms,
    cwd = options.cwd,
  })
  if process then
    local result = process:wait()
    if result.signal == 0 and result.stdout then
      return vim.gsplit(result.stdout, "\n", {
        plain = true,
        trimempty = true,
      })
    end
  end
  return iter.empty()
end

---@class tex_filetypes.util.kpse.LookupOptions: tex_filetypes.util.kpse.Options
---@field private var_value? nil

---@param filenames string[]
---@param options? tex_filetypes.util.kpse.LookupOptions
function M.lookup(filenames, options)
  if #filenames == 0 then
    return iter.empty()
  end
  options = vim.tbl_extend("keep", {}, options or {})
  options.var_value = nil
  return kpsewhich(options, filenames)
end

return M
