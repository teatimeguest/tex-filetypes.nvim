local M = {}

---@class tex_filetypes.include.tex.Config: tex_filetypes.util.kpse.LookupOptions
---@field suffixes? string[]
---@field pattern? string[] | fun(name: string): string[]
---@field list? true
---@field TF? true

---@class tex_filetypes.include.tex.Commands
-- stylua: ignore
M.base = {
  -- ltfiles.dtx
  includeonly                = { list = true },
  include                    = { },
  input                      = { },
  IfFileExists               = { },
  InputIfFileExists          = { },
  -- ltbibl.dtx
  bibliography               = { format = "bib", list = true },
  bibliographystyle          = { format = "bst" },
  -- ltclass.dtx
  RequirePackage             = { suffixes = { ".sty" }, list = true },
  LoadClass                  = { suffixes = { ".cls" } },
  PassOptionsToPackage       = { suffixes = { ".sty" }, list = true },
  PassOptionsToClass         = { suffixes = { ".cls" } },
  RequirePackageWithOptions  = { suffixes = { ".sty" }, list = true },
  LoadClassWithOptions       = { suffixes = { ".cls" } },
  IfPackageLoaded            = { suffixes = { ".sty" }, TF = true },
  IfClassLoaded              = { suffixes = { ".cls" }, TF = true },
  -- ["@ifpackageloaded"]    = { suffixes = { ".sty" } },
  -- ["@ifclassloaded"]      = { suffixes = { ".cls" } },
  IfPackageAtLeast           = { suffixes = { ".sty" }, TF = true },
  IfClassAtLeast             = { suffixes = { ".cls" }, TF = true },
  IfFileAtLeasst             = { TF = true },
  -- ["@ifpackagelater"]     = { suffixes = { ".sty" } },
  -- ["@ifclasslater"]       = { suffixes = { ".cls" } },
  IfPackageLoadedWithOptions = { suffixes = { ".sty" }, TF = true },
  IfClassLoadedWithOptions   = { suffixes = { ".cls" }, TF = true },
  -- ["@ifclasswith"]        = { suffixes = { ".cls" } },
  -- ["@ifpackagewith"]      = { suffixes = { ".sty" } },
  documentclass              = { suffixes = { ".cls" } },
  documentstyle              = { suffixes = { ".cls" } },
  usepackage                 = { suffixes = { ".sty" }, list = true },
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
M.expl3 = {
  ["lua_load_module:n"] = { format = "lua" },
}

---@class tex_filetypes.include.tex.Commands
M.pgf = {
  usegdlibrary = {
    pattern = { "pgf.gd.%s.library", "pgf.gd.%s", "%s.library", "%s" },
    format = "lua",
    list = true,
  },
  usepgflibrary = {
    pattern = { "pgflibrary%s.code.tex" },
    list = true,
  },
  usetikzlibrary = {
    pattern = { "tikzlibrary%s.code.tex", "pgflibrary%s.code.tex" },
    list = true,
  },
}

---@class tex_filetypes.include.tex.Commands
M.tcolorbox = {
  tcbuselibrary = {
    pattern = { "tcb%s.code.tex" },
    list = true,
  },
}

return M
