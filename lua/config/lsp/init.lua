local lspconfig = require("lspconfig")
local is_available, mason_lspconfig = pcall(require, "mason-lspconfig")
if not is_available then
  return
end

local on_attach = function(client)
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local lscmp_available, lscmp = pcall(require, "cmp_nvim_lsp")
if lscmp_available then
  capabilities = lscmp.update_capabilities(capabilities)
end
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
  "clangd",
  "html",
  "cssls",
  "tsserver",
  "sumneko_lua",
  "phpactor",
  "pyright",
  "jdtls"
}
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = false,
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach and require("config/lsp/settings").on_attach(),
    capabilities = capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "config/lsp/lsconf" .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end
