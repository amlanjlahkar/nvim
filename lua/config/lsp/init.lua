local is_available, _ = pcall(require, "lspconfig")
local is_available_mason, mason = pcall(require, "mason")
if is_available == false or is_available_mason == false then
  return
end

require("lspconfig.ui.windows").default_options.border = "single"
mason.setup({
  ui = {
    border = "single",
    icons = {
      package_installed = " ",
      package_pending = "勒",
      package_uninstalled = " ",
    },
  },
})

local server = require("config.lsp.server"):setup_server()
if server.is_installed then
  require("config.lsp.handler").setup()
  require("config.lsp.null-ls")
end
