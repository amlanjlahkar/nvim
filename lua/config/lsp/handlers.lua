local M = {}

M.setup = function()
  vim.diagnostic.config {
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

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local trouble_setup = {
    icons = true,
    fold_open = "",
    fold_closed = "",
    indent_lines = false,
    use_diagnostic_signs = true,
  }
  require("trouble").setup(trouble_setup)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
end

local wk = require("which-key")
local function lsp_keymaps()
  local lsp_wk_mappings = {
    l = {
      name = "LSP",
      gd = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto definition" },
      gi = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
      gr = { "<cmd>TroubleToggle lsp_references<CR>", "List references" },
      gn = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto next diagnostic" },
      gp = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto previous diagnostic" },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
      k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover information" },
      l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show line diagnostic" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Show document diagnostics" },
      D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Show workspace diagnostics" },
    },
  }
  wk.register(lsp_wk_mappings, { prefix = "<leader>" })
end

M.on_attach = function(client, bufnr)
  M.capabilities = vim.lsp.protocol.make_client_capabilities()
  M.capabilities.textDocument.completion.completionItem.snippetSupport = true

  local is_cmp_available, cmp_nvim = pcall(require, "cmp_nvim_lsp")
  if is_cmp_available then
    M.capabilities = cmp_nvim.default_capabilities(M.capabilities)
  end

  local is_navic_available, navic = pcall(require, "nvim-navic")
  if is_navic_available then
    if client.server_capabilities.documentSymbolProvider then
      local fname = vim.fn.expand("%:t")
      local ficon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype)
      vim.wo.winbar = string.format("%s %s  %s", ficon, fname, "%{%v:lua.require'nvim-navic'.get_location()%}")
      navic.attach(client, bufnr)
    end
  end

  -- Highlight references for symbol  under cursor
  if client.server_capabilities.documentHighlightProvider then
    local hl = vim.api.nvim_set_hl
    hl(0, "LspReferenceRead", { bg = "#2a2f41" })
    hl(0, "LspReferenceText", { bg = "#2a2f41" })
    hl(0, "LspReferenceWrite", { bg = "#2a2f41" })

    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  lsp_keymaps()
end

return M
