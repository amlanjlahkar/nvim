local is_available, ls = pcall(require, "luasnip")
if not is_available then
  return
end
local types = require("luasnip.util.types")

ls.config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  region_check_events = "CursorMoved,CursorHold,InsertEnter",
  delete_check_events = "InsertLeave",
  enable_autosnippets = false,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "", "SnipChoiceNode" } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "", "SnipInsertNode" } },
      },
    },
  },
})

require("luasnip.loaders.from_vscode").lazy_load({
  paths = vim.fn.stdpath("data") .. "/site/pack/packer/opt/friendly-snippets",
})
require("luasnip.loaders.from_lua").lazy_load({
  paths = vim.fn.stdpath("config") .. "/luasnippet",
})
