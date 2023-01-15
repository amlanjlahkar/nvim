local M = {
  border = "single",
  signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
    virt_text = "",
  },
}

function M:setup()
  for type, icon in pairs(self.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  require("lspconfig.ui.windows").default_options.border = self.border

  require("fidget").setup({
    text = { spinner = "moon" },
  })
end

return M
