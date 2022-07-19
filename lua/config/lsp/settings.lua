local M = {}

local function lsp_ui()
  vim.diagnostic.config {
    virtual_text = false,
    signs = false,
    update_in_insert = true,
    underline = false,
    severity_sort = false,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "Diagnostic Info",
      prefix = "",
    },
  }
  local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local function lsp_keymaps()
  local opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>lgd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "<leader>lgD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "<leader>lgi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.keymap.set("n", "<leader>lgr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

M.on_attach = function()
  lsp_keymaps()
  lsp_ui()
end

return M
