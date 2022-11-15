local ls = require("luasnip")
local types = require("luasnip.util.types")

local key = require("core.keymap.maputil")
local tab = vim.api.nvim_replace_termcodes("<TAB>", true, false, true)

-- stylua: ignore
key.ismap({
  { "<TAB>", function()
      if ls.expand_or_locally_jumpable() then
        ls.expand_or_jump()
      else
        vim.api.nvim_feedkeys(tab, "n", false)
      end
    end,
  },
  { "<S-TAB>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end,
  },
})

ls.config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  region_check_events = "CursorMoved,CursorHold,InsertEnter",
  delete_check_events = "TextChanged",
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
  paths = vim.fn.stdpath("config") .. "/lua/config/completion/snippet/lang",
})
