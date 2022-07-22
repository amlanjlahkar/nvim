local function prequire(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end
local ls = prequire "luasnip"

ls.config.setup {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  region_check_events = "CursorMoved,CursorHold,InsertEnter",
  delete_check_events = "InsertLeave",
  enable_autosnippets = true,
}

-- load custom defined snippets
require("luasnip.loaders.from_vscode").lazy_load {
  paths = vim.fn.stdpath "config" .. "/snippets",
}
