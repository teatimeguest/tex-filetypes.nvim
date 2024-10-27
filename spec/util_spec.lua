local util = require("tex-filetypes.util")

---@type integer
local lipsum = vim.api.nvim_create_buf(false, true)

setup(function()
  vim.api.nvim_buf_set_lines(lipsum, 0, 8, false, {
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
    "tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
    "veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea",
    "commodo consequat. Duis aute irure dolor in reprehenderit in voluptate",
    "velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint",
    "occaecat cupidatat non proident, sunt in culpa qui officia deserunt",
    "mollit anim id est laborum.",
  })
end)

teardown(function()
  if lipsum and vim.api.nvim_buf_is_valid(lipsum) then
    vim.api.nvim_buf_delete(lipsum, { force = true })
  end
end)

describe("find_all", function()
  it("yields all substrings", function()
    local matches = util.find_all("aaaaa", "aa")
    assert.same(matches(), { 0, 2 })
    assert.same(matches(), { 1, 3 })
    assert.same(matches(), { 2, 4 })
    assert.same(matches(), { 3, 5 })
    assert.is_nil(matches())
  end)
end)

describe("regex.gmatch_line", function()
  it("yields all matches", function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    finally(function()
      if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end)
    vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { "aaaaa" })
    local matches = util.regex.gmatch_line(vim.regex("aa"), bufnr, 0)
    assert.same(matches(), { 0, 2 })
    assert.same(matches(), { 2, 4 })
    assert.is_nil(matches())
  end)

  it("starts search from the given offset", function()
    local re = vim.regex([[\<s[aeiou]n\?]])
    local matches = util.regex.gmatch_line(re, lipsum, 0, 30)
    assert.same(matches(), { 57, 59 })
    assert.is_nil(matches())
  end)
end)

describe("search_forward", function()
  local re = vim.regex("[Uu]t")

  it("returns the position of the next match", function()
    assert.same(util.search_forward(re, lipsum, 0, 0), { 1, 18, 1, 20 })
    assert.same(util.search_forward(re, lipsum, 1, 19), { 1, 52, 1, 54 })
    assert.same(util.search_forward(re, lipsum, 1, 54), { 2, 55, 2, 57 })
    assert.same(util.search_forward(re, lipsum, 2, 56), { 3, 25, 3, 27 })
    assert.is_nil(util.search_forward(re, lipsum, 3, 26))
  end)

  it("checks lines up to `max_lines`", function()
    assert.is_nil(util.search_backward(re, lipsum, 2, 56, 1))
  end)
end)

describe("search_backward", function()
  local re = vim.regex([[\<s[aeiou]n\?]])

  it("returns the position of the previous match", function()
    assert.is_nil(util.search_backward(re, lipsum, 0, 19))
    assert.same(util.search_backward(re, lipsum, 0, 58), { 0, 18, 0, 20 })
    assert.same(util.search_backward(re, lipsum, 4, 62), { 0, 57, 0, 59 })
    assert.same(util.search_backward(re, lipsum, 5, 34), { 4, 61, 4, 64 })
    assert.same(util.search_backward(re, lipsum, 6, 27), { 5, 33, 5, 36 })
  end)

  it("checks lines up to `max_lines`", function()
    assert.is_nil(util.search_backward(re, lipsum, 4, 62, 4))
  end)
end)
