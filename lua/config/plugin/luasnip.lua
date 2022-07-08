local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local ls = prequire("luasnip")
local types = require "luasnip.util.types"
local snip = ls.snippet
local ins = ls.insert_node
local tn = ls.text_node

ls.config.setup({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

ls.add_snippets("all", {
  ls.snippet("ternary", {
    ins(1, "cond"), tn(" ? "), ins(2, "then"), tn(" : "), ins(3, "else")
  })
})

