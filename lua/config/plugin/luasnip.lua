local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local ls = prequire("luasnip")
local snip = ls.snippet
local types = require "luasnip.util.types"

ls.config.setup({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

