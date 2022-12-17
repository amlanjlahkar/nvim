local is_avail, trouble = pcall(require, "trouble")
if not is_avail then
  return
end

local trouble_ui = {
  icons = false,
  fold_open = "",
  fold_closed = "",
  indent_lines = false,
  use_diagnostic_signs = true,
}

local diagnostic_ui = {
  signs = false,
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  virtual_text = false,
  --[[ virtual_text = {
      prefix = "",
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
}
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

trouble.setup(trouble_ui)
vim.diagnostic.config(diagnostic_ui)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
require("lspconfig.ui.windows").default_options.border = "single"
