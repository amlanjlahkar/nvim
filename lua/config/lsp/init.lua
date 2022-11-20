local is_available, _ = pcall(require, "lspconfig")
if not is_available then
  return
end

require("config.lsp.ui")
local server = require("config.lsp.server"):setup_server()
if server.is_installed then
  require("config.lsp.null-ls")
end
