local is_available, _ = pcall(require, "lspconfig")
if not is_available then
  return
end
require("lspconfig.ui.windows").default_options.border = "single"

local servers = require("config.lsp.server"):setup_servers()
if servers.is_installed then
  require("config.lsp.handler").setup()
  require("config.lsp.null-ls")
end
