local is_available, _ = pcall(require, "lspconfig")
if not is_available then
  return
end
require("lspconfig.ui.windows").default_options.border = "single"

local server = require("config.lsp.server"):setup_server()
if server.is_installed then
  require("config.lsp.handler").setup()
  require("config.lsp.null-ls")
end
