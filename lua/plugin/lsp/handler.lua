local ui = require("plugin.lsp.ui")
local lsp = vim.lsp

local M = {}

function M.setup()
  require("lspconfig.ui.windows").default_options.border = ui.border
  lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = ui.border })
  lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = ui.border })
  lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    signs = false,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    virtual_text = false,
    --[[ virtual_text = {
      prefix = ui.signs.virt_text,
      source = "if_many",
      severity = { max = vim.diagnostic.severity.WARN }
    }, ]]
    float = {
      focusable = false,
      style = "minimal",
      border = "single",
      source = "always",
      header = "Diagnostic Info",
      prefix = "",
    },
  })
end

return M
