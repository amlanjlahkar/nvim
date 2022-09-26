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

local wk = require("which-key")
local function lsp_keymaps()
  local lsp_wk_mappings = {
    l = {
      name = "LSP",
      gd = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition" },
      gi = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
      gr = { "<cmd>lua vim.lsp.buf.references()<CR>", "List references" },
      r  = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" },
      s  = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
      k  = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover information" },
      d  = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show line diagnostic" },
      D  = { "<cmd>TroubleToggle document_diagnostics<cr>", "Show diagnostics" },
    },
  }
  wk.register(lsp_wk_mappings, { prefix = "<leader>" })
end

M.on_attach = function()
  lsp_keymaps()
  lsp_ui()
end

return M
