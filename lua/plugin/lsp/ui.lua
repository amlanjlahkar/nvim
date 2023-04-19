local M = {
  border = "solid",
  signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  virtual_prefix = " ",
}

function M:diagnostic_opts()
  return {
    signs = false,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
    virtual_text = false,
    --[[ virtual_text = {
      spacing = 3,
      prefix = ui.virtual_prefix,
      source = "if_many",
      severity = { max = vim.diagnostic.severity.WARN }
    }, ]]
    float = {
      focusable = false,
      style = "minimal",
      border = self.border,
      source = "always",
      header = "Diagnostic Info",
      prefix = "",
    },
  }
end

function M:setup()
  for type, icon in pairs(self.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  require("lspconfig.ui.windows").default_options.border = self.border
end

return M
