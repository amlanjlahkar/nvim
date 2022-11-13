local is_available, _ = pcall(require, "lspconfig")
if not is_available then
  return
end

local server = require("config.lsp.server"):setup_server()
if server.is_installed then
  require("config.lsp.handler").setup()
  require("config.lsp.null-ls")
  require("config.lsp.extras")
end
