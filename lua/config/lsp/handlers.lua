local M = {}

M.setup = function()
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

  local trouble_setup = {
    icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
    use_diagnostic_signs = true
  }
  local is_trouble_available, trouble = pcall(require, "trouble")
  if is_trouble_available then
    trouble.setup(trouble_setup)
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

M.on_attach = function(client)
  M.capabilities = vim.lsp.protocol.make_client_capabilities()
  M.capabilities.textDocument.completion.completionItem.snippetSupport = true
  local is_cmp_available, cmp_nvim = pcall(require, "cmp_nvim_lsp")
  if is_cmp_available then
    M.capabilities = cmp_nvim.update_capabilities(M.capabilities)
  end

  lsp_keymaps()
end

return M
