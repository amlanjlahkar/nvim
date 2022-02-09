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
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {{"●", "Orange"}}
            }
        },
        [types.insertNode] = {
            active = {
                virt_text = {{"●", "Blue"}}
            }
        },
    },
})

-- source the conf file again, which will reload the snippets
vim.api.nvim_set_keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/config/plugin/luasnip.lua<CR>", { noremap = true, silent = true })
