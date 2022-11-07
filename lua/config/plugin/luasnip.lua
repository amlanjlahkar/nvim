local is_available, ls = pcall(require, "luasnip")
if not is_available then
  return
end

ls.config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  region_check_events = "CursorMoved,CursorHold,InsertEnter",
  delete_check_events = "InsertLeave",
  enable_autosnippets = true,
})

-- load custom defined snippets
require("luasnip.loaders.from_vscode").lazy_load({
  paths = vim.fn.stdpath("config") .. "/snippet",
})
