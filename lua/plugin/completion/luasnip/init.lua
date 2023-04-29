local ls = require("luasnip")

local M = {}

function M.setup_mappings()
  local key = require("core.utils.map")
  local tab = vim.api.nvim_replace_termcodes("<TAB>", true, false, true)

  key.ismap({
    {
      "<TAB>",
      function()
        if ls.expand_or_locally_jumpable() then
          ls.expand_or_jump()
        else
          vim.api.nvim_feedkeys(tab, "n", false)
        end
      end,
    },
    {
      "<S-TAB>",
      function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
    },
  })
end

function M.setup()
  local types = require("luasnip.util.types")
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
  require("luasnip.loaders.from_lua").lazy_load({
    paths = vim.fn.stdpath("config") .. "/lua/plugin/completion/luasnip/snippets",
  })
  M.setup_mappings()
end

return M
