local is_available, _ = pcall(require, "lspconfig")
if not is_available then
  return
end
require("lspconfig.ui.windows").default_options.border = "single"

require("config.lsp.server")
require("config.lsp.handler").setup()
require("config.lsp.null-ls")
