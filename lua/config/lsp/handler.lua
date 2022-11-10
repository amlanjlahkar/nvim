local M = {}

M.setup = function()
  vim.diagnostic.config({
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
  })

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

-- stylua: ignore
local function lsp_keymaps(bufnr)
  local key = require("core.keymap.maputil")
  local cmd, opts = key.cmd, key.new_opts
  key.nmap({
    { "<leader>lgd",  cmd("lua vim.lsp.buf.definition()"),          opts(bufnr, "LSP: Goto definition") },
    { "<leader>lgi",  cmd("lua vim.lsp.buf.implementation()"),      opts(bufnr, "LSP: Goto implementation") },
    { "<leader>lr",   cmd("lua vim.lsp.buf.rename()"),              opts(bufnr, "LSP: Rename symbol under cursor") },
    { "<leader>la",   cmd("lua vim.lsp.buf.code_action()"),         opts(bufnr, "LSP: List available code actions") },
    { "<leader>ls",   cmd("lua vim.lsp.buf.signature_help()"),      opts(bufnr, "LSP: Show signature info for symbol under cursor") },
    { "<leader>lk",   cmd("lua vim.lsp.buf.hover()"),               opts(bufnr, "LSP: Show hover information") },
    { "<leader>lgr",  cmd("TroubleToggle lsp_references"),          opts(bufnr, "LSP/Trouble: List references for symbol under cursor") },
    { "<leader>ld",   cmd("TroubleToggle document_diagnostics"),    opts(bufnr, "LSP/Trouble: List document diagnostics") },
    { "<leader>lD",   cmd("TroubleToggle workspace_diagnostics"),   opts(bufnr, "LSP/Trouble: List workspace diagnostics") },
    { "<leader>ll",   cmd("lua vim.diagnostic.open_float()"),       opts(bufnr, "LSP: Show line diagnostic") },
    { "]d",           cmd("lua vim.diagnostic.goto_next()"),        opts(bufnr, "LSP: Goto next diagnostic occurrence") },
    { "[d",           cmd("lua vim.diagnostic.goto_prev()"),        opts(bufnr, "LSP: Goto previous diagnostic occurrence") },
  })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
local is_cmp_available, cmp_nvim = pcall(require, "cmp_nvim_lsp")
if is_cmp_available then
  M.capabilities = cmp_nvim.default_capabilities(M.capabilities)
end

M.on_attach = function(client, bufnr)
  local is_navic_available, navic = pcall(require, "nvim-navic")
  if is_navic_available then
    if client.server_capabilities.documentSymbolProvider then
      local fname = vim.fn.expand("%:t")
      local ficon = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype)
      vim.wo.winbar = string.format(" %s %s  %s", ficon, fname, "%{%v:lua.require'nvim-navic'.get_location()%}")
      navic.attach(client, bufnr)
    end
  end

  -- Highlight references for symbol under cursor
  if client.server_capabilities.documentHighlightProvider then
    local is_defined, _ = pcall(vim.cmd, "silent hi LspReference")
    if is_defined then
      vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReference" })
      vim.api.nvim_set_hl(0, "LspReferenceText", { link = "LspReference" })
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReference" })
    end

    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
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

  lsp_keymaps(bufnr)
end

return M
