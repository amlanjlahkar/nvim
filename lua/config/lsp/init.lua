local is_available, _ = pcall(require, "lspconfig")
if not is_available then
  return
end

require("config.lsp.servers")
require("config.lsp.handlers").setup()
require("config.lsp.null-ls")
