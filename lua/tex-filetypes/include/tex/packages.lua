local M = {}

---@class tex_filetypes.include.tex.Config: tex_filetypes.kpsewhich.Options
---@field suffixes? string[]
---@field pattern? string[] | fun(name: string): string[]
---@field list? true

---@class tex_filetypes.include.tex.Commands
-- stylua: ignore
M.base = {
  IfClassAtLeastF              = { suffixes = { ".cls" } },
  IfClassAtLeastT              = { suffixes = { ".cls" } },
  IfClassAtLeastTF             = { suffixes = { ".cls" } },
  IfClassLoadedF               = { suffixes = { ".cls" } },
  IfClassLoadedT               = { suffixes = { ".cls" } },
  IfClassLoadedTF              = { suffixes = { ".cls" } },
  IfClassLoadedWithOptionsF    = { suffixes = { ".cls" } },
  IfClassLoadedWithOptionsT    = { suffixes = { ".cls" } },
  IfClassLoadedWithOptionsTF   = { suffixes = { ".cls" } },
  IfFileAtLeasstF              = { },
  IfFileAtLeasstT              = { },
  IfFileAtLeasstTF             = { },
  IfFileExists                 = { },
  IfPackageAtLeastF            = { suffixes = { ".sty" } },
  IfPackageAtLeastT            = { suffixes = { ".sty" } },
  IfPackageAtLeastTF           = { suffixes = { ".sty" } },
  IfPackageLoadedF             = { suffixes = { ".sty" } },
  IfPackageLoadedT             = { suffixes = { ".sty" } },
  IfPackageLoadedTF            = { suffixes = { ".sty" } },
  IfPackageLoadedWithOptionsF  = { suffixes = { ".sty" } },
  IfPackageLoadedWithOptionsT  = { suffixes = { ".sty" } },
  IfPackageLoadedWithOptionsTF = { suffixes = { ".sty" } },
  InputIfFileExists            = { },
  LoadClass                    = { suffixes = { ".cls" } },
  LoadClassWithOptions         = { suffixes = { ".cls" } },
  PassOptionsToClass           = { suffixes = { ".cls" } },
  PassOptionsToPackage         = { suffixes = { ".sty" }, list = true },
  RequirePackage               = { suffixes = { ".sty" }, list = true },
  RequirePackageWithOptions    = { suffixes = { ".sty" }, list = true },
  -- ["@ifclasslater"]         = { suffixes = { ".cls" } },
  -- ["@ifclassloaded"]        = { suffixes = { ".cls" } },
  -- ["@ifclasswith"]          = { suffixes = { ".cls" } },
  -- ["@ifpackagelater"]       = { suffixes = { ".sty" } },
  -- ["@ifpackageloaded"]      = { suffixes = { ".sty" } },
  -- ["@ifpackagewith"]        = { suffixes = { ".sty" } },
  bibliography                 = { format = "bib" },
  documentclass                = { suffixes = { ".cls" } },
  include                      = { },
  input                        = { },
  usepackage                   = { suffixes = { ".sty" }, list = true },
}

---@class tex_filetypes.include.tex.Commands
-- stylua: ignore
M.beamer = {
  usecolortheme = { pattern = { "beamercolortheme%s.sty" } },
  usefonttheme  = { pattern = { "beamerfonttheme%s.sty" } },
  useinnertheme = { pattern = { "beamerinnertheme%s.sty" } },
  useoutertheme = { pattern = { "beameroutertheme%s.sty" } },
  usetheme      = { pattern = { "beamertheme%s.sty" } },
}

---@class tex_filetypes.include.tex.Commands
-- stylua: ignore
M.biblatex = {
  RequireBibliographyStyle = { suffixes = { ".bbx" } },
  RequireCitationStyle     = { suffixes = { ".cbx" } },
  addbibresource           = { format = "bib" },
}

---@class tex_filetypes.include.tex.Commands
M.pgf = {
  usegdlibrary = {
    pattern = function(name)
      return vim
        .iter({ "pgf.gd.%s.library", "pgf.gd.%s", "%s.library", "%s" })
        :map(
          ---@param pat string
          ---@return string[]
          function(pat)
            -- https://github.com/TeX-Live/luatex/blob/1.15.0/source/texk/web2c/luatexdir/lua/luainit.c#L646
            local lua = pat:format(name)
            return { lua:gsub([[\.]], "/"), lua }
          end
        )
        :flatten()
        :totable()
    end,
    progname = "luatex",
    format = "lua",
    list = true,
  },
  usetikzlibrary = {
    pattern = { "tikzlibrary%s.code.tex", "pgflibrary%s.code.tex" },
    list = true,
  },
}

---@class tex_filetypes.include.tex.Commands
M.tcolorbox = {
  usetcblibrary = {
    pattern = { "tcb%s.code.tex" },
    list = true,
  },
}

return M
