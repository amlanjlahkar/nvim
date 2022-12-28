local M = {}
-- stylua: ignore
function M.keymaps(bufnr)
  local lsp = vim.lsp.buf
  local key = require("core.keymap.maputil")
  local cmd, opts = key.cmd, key.new_opts
  key.nmap({
    { "K",            lsp.hover,                                          opts(bufnr, "LSP: Show hover information") },
    { "<leader>lr",   lsp.rename,                                         opts(bufnr, "LSP: Rename symbol under cursor") },
    { "<leader>la",   lsp.code_action,                                    opts(bufnr, "LSP: List available code actions") },
    { "<leader>lh",   lsp.signature_help,                                 opts(bufnr, "LSP: Show signature info for symbol under cursor") },
    { "<leader>lt",   lsp.type_definition,                                opts(bufnr, "LSP: Goto type definition for symbol under cursor") },
    { "<leader>ll",   vim.diagnostic.open_float,                          opts(bufnr, "LSP: Show line diagnostic") },
    { "]d",           vim.diagnostic.goto_next,                           opts(bufnr, "LSP: Goto next diagnostic occurrence") },
    { "[d",           vim.diagnostic.goto_prev,                           opts(bufnr, "LSP: Goto previous diagnostic occurrence") },
    { "gd",           cmd("TroubleToggle lsp_definitions"),               opts(bufnr, "LSP: Goto definition") },
    { "gi",           cmd("TroubleToggle lsp_implementations"),           opts(bufnr, "LSP: Goto implementation") },
    { "gr",           cmd("TroubleToggle lsp_references"),                opts(bufnr, "LSP/Trouble: List references for symbol under cursor") },
    { "<leader>ld",   cmd("TroubleToggle document_diagnostics"),          opts(bufnr, "LSP/Trouble: List document diagnostics") },
    { "<leader>lD",   cmd("TroubleToggle workspace_diagnostics"),         opts(bufnr, "LSP/Trouble: List workspace diagnostics") },
    { "<leader>ls",   cmd("Telescope lsp_dynamic_workspace_symbols"),     opts(bufnr, "LSP/Telescope: Search for workspace symbols") },
    { "<leader>f",    function() require("plugin.null-ls").format() end,  opts("Lsp/Null-ls: Format buffer") },
  })
  key.imap({ "<C-k>", lsp.signature_help, })
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
local is_cmp_available, cmp_nvim = pcall(require, "cmp_nvim_lsp")
if is_cmp_available then
  M.capabilities = cmp_nvim.default_capabilities(M.capabilities)
end

function M.on_attach(client, bufnr)
  --[[ local is_navic_available, navic = pcall(require, "nvim-navic")
  if is_navic_available then
    if client.server_capabilities.documentSymbolProvider then
      local fname = vim.fn.expand("%:t")
      local is_avail, icons = pcall(require, "nvim-web-devicons")
      if is_avail then
        local ficon = icons.get_icon_by_filetype(vim.bo.filetype)
        vim.wo.winbar = string.format(" %s %s  %s", ficon, fname, "%{%v:lua.require'nvim-navic'.get_location()%}")
      else
        vim.wo.winbar = string.format(" %s  %s", fname, "%{%v:lua.require'nvim-navic'.get_location()%}")
      end
      navic.attach(client, bufnr)
    end
  end ]]

  -- Highlight references for symbol under cursor
  if client.server_capabilities.documentHighlightProvider then
    local is_defined, _ = pcall(vim.cmd, "silent hi LspReference")
    if is_defined then
      vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReference" })
      vim.api.nvim_set_hl(0, "LspReferenceText", { link = "LspReference" })
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReference" })
    end

    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
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
  M.keymaps(bufnr)
end

return M
