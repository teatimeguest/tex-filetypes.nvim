local detect = require("tex-filetypes.filetype.detect")

---@type { [string]: vim.filetype.add.filetypes }
local M = {}

M._ = {
  pattern = {
    [".-%.def"] = { detect.def, { priority = 10 } },
    [".-%.cfg"] = { detect.cfg, { priority = 10 } },
  },
}

M.babel = {
  extension = {
    ldf = "tex",
  },
  filename = {
    ["bblopts.cfg"] = detect.cfg,
  },
}

M.babelbib = {
  pattern = {
    -- `.bdf` is also used by `bdf`.
    [".-/texmf[/-].-%.bdf"] = "tex",
  },
}

M.base = {
  extension = {
    enc = "postscr",
    fd = "tex",
    fdd = "tex",
  },
  filename = {
    ["texsys.cfg"] = detect.cfg,
    ["fonttext.cfg"] = detect.cfg,
    ["fontmath.cfg"] = detect.cfg,
    ["preload.cfg"] = detect.cfg,
    ["hyphen.cfg"] = detect.cfg,
    ["latex209.cfg"] = detect.cfg,
    ["sfonts.cfg"] = detect.cfg,
    ["ltnews.cfg"] = detect.cfg,
    ["ltxdoc.cfg"] = detect.cfg,
    ["ltxguide.cfg"] = detect.cfg,
  },
}

M.biblatex = {
  extension = {
    lbx = "tex",
    dbx = "tex",
  },
  filename = {
    ["biblatex.cfg"] = detect.cfg,
  },
}

M.bibtex = {
  extension = {
    blg = "log",
  },
}

M.bibtool = {
  extension = {
    bibtoolrsc = "bibtoolrsc",
  },
  filename = {
    ["bibtool.rsc"] = "bibtoolrsc",
    [".bibtoolrsc"] = "bibtoolrsc",
  },
  pattern = {
    -- `.rsc` is also used by `routeros`.
    [".-/texmf[/-].-%.rsc"] = "bibtoolrsc",
  },
}

M.chktex = {
  extension = {
    chktexrc = "chktexrc",
  },
  filename = {
    chktexrc = "chktexrc",
    [".chktexrc"] = "chktexrc",
  },
}

M.cleveref = {
  filename = {
    ["cleveref.cfg"] = detect.cfg,
  },
}

M.csquotes = {
  filename = {
    ["csquotes.cfg"] = detect.cfg,
  },
}

M.docstrip = {
  filename = {
    ["docstrip.cfg"] = detect.cfg,
  },
}

M.dvips = {
  filename = {
    ["psfonts.map"] = "fontmap",
  },
}

M.fontinst = {
  extension = {
    etx = "tex",
    mtx = "tex",
  },
  filename = {
    ["fontinst.rc"] = "tex",
    ["finstmsc.rc"] = "tex",
    ["fontdoc.cfg"] = detect.cfg,
  },
}

M.fontspec = {
  extension = {
    fontspec = "tex",
  },
  filename = {
    ["fontspec.cfg"] = detect.cfg,
  },
}

M.geometry = {
  filename = {
    ["geometry.cfg"] = detect.cfg,
  },
}

M.hyperref = {
  filename = {
    ["hyperref.cfg"] = detect.cfg,
  },
}

M.l3build = {
  extension = {
    lvt = "tex",
    pvt = "tex",
  },
}

M.l3doc = {
  filename = {
    ["l3doc.cfg"] = detect.cfg,
  },
}

M.listings = {
  filename = {
    ["listings.cfg"] = detect.cfg,
  },
  pattern = {
    ["listings%-[^/]+%.prf"] = "tex",
  },
}

M.luaotfload = {
  extension = {
    luaotfloadrc = "dosini",
  },
  filename = {
    ["luaotfloadrc"] = "dosini",
    ["luaotfload.conf"] = "dosini",
  },
}

M.luatex = {
  extension = {
    luatex = "lua",
    texlua = "lua",
  },
}

M.microtype = {
  filename = {
    ["microtype.cfg"] = detect.cfg,
  },
  pattern = {
    ["mt%-[^/]+%.cfg"] = detect.cfg,
  },
}

M.pdftex = {
  filename = {
    ["pdftex.map"] = "fontmap",
  },
}

M.pgf = {
  filename = {
    ["pgf.cfg"] = detect.cfg,
  },
}

M.refstyle = {
  filename = {
    ["refstyle.cfg"] = detect.cfg,
  },
}

M.siunitx = {
  filename = {
    ["siunitx.cfg"] = detect.cfg,
  },
}

M["tex-ini-files"] = {
  pattern = {
    -- `.ini` is also used by `ini`.
    [".-%.ini"] = detect.ini,
  },
}

M.tex4ht = {
  extension = {
    ["4ht"] = "tex",
  },
}

M.texlive = {
  filename = {
    ["DEPENDS.txt"] = "dependstxt",
    ["texlive.profile"] = "texliveprofile",
    ["installation.profile"] = "texliveprofile",
  },
  pattern = {
    [".-%.DEPENDS%.txt"] = "dependstxt",
    -- `.profile` is also used by `sh`.
    [".-%.profile"] = { detect.profile, { priority = 10 } },
  },
}

M.texware = {
  extension = {
    vpl = "propertylist",
  },
  pattern = {
    -- `.pl` is also used by `perl` and `prolog`.
    [".-%.pl"] = { detect.pl, { priority = 10 } },
  },
}

M.web2c = {
  filename = {
    ["texfonts.map"] = "fontmap",
  },
  extension = {
    map = detect.map,
  },
}

M.xecjk = {
  filename = {
    ["xeCJK.cfg"] = detect.cfg,
  },
  pattern = {
    ["xeCJK%-[^/]+%.cfg"] = detect.cfg,
  },
}

M.xmltex = {
  filename = {
    ["xmltex.cfg"] = detect.cfg,
  },
}

return M
