---@param args vim.filetype.match.args
---@return integer bufnr
local function create_buffer(args)
  local bufnr = args.buf
  if not bufnr then
    bufnr = vim.api.nvim_create_buf(false, true)
    finally(function()
      if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end)
  end
  if args.filename then
    vim.api.nvim_buf_set_name(bufnr, args.filename)
  end
  if args.contents then
    vim.api.nvim_buf_set_text(bufnr, 0, 0, 0, 0, args.contents)
  end
  return bufnr
end

---@param filename string
---@return vim.filetype.match.args
local function use_fixtures(filename)
  local path = vim.fs.joinpath("./spec/__fixtures__", filename)
  local contents = vim.iter(io.lines(path)):totable()
  local bufnr = create_buffer({ contents = contents })
  return { buf = bufnr, filename = filename }
end

local tex_filetypes = require("tex-filetypes")
local dialect = tex_filetypes.dialect

vim.filetype.add(tex_filetypes.filetypes)

describe("lua", function()
  describe("is_texlua", function()
    it("from extension `.luatex`", function()
      assert.is_true(dialect.is_texlua({ filename = "example.luatex" }))
    end)

    it("from extension `.tlu`", function()
      assert.is_true(dialect.is_texlua({ filename = "example.tlu" }))
    end)

    it("from shebang with `luatex`", function()
      assert.is_true(dialect.is_texlua({
        contents = { "#!/usr/local/texlive/2024/bin/x86_64-linux/luatex" },
      }))
    end)

    it("from shebang with `texlua`", function()
      assert.is_true(
        dialect.is_texlua({ contents = { "#!/usr/bin/env texlua" } })
      )
    end)

    it("from contents", function()
      assert.is_true(
        dialect.is_texlua({ contents = { "kpse.set_program_name('lua')" } })
      )
    end)
  end)
end)

describe("propertylist", function()
  it("cannot detect ft of nova.pl by filename", function()
    assert.is_not.same(
      vim.filetype.match({ filename = "nova.pl" }),
      "propertylist"
    )
  end)

  it("detects ft of nova.pl", function()
    local fixture = use_fixtures("nova.pl")
    assert.same(vim.filetype.match(fixture), "propertylist")
  end)

  it("detects ft of example.vpl by filename", function()
    assert.same(
      vim.filetype.match({ filename = "example.vpl" }),
      "propertylist"
    )
  end)
end)
