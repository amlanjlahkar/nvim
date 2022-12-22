local M = {
  signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
    Diagnostic = "",
  },
}

function M:setup()
  require("lspconfig.ui.windows").default_options.border = "single"
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

  vim.diagnostic.config({
    signs = false,
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    virtual_text = false,
    --[[ virtual_text = {
      prefix = self.signs.Diagnostic,
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

  for type, icon in pairs(self.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

end

return M
