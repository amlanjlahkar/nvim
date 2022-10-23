local is_masonconfig_available, mason_lspconfig = pcall(require, "mason-lspconfig")
local is_lspconfig_available, lspconfig = pcall(require, "lspconfig")

if not (is_lspconfig_available or is_masonconfig_available) then
  return
end

local servers = {
  "clangd",
  "html",
  "cssls",
  "tsserver",
  "sumneko_lua",
  "phpactor",
  "pyright",
  "tailwindcss",
}
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = false,
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("config.lsp.handlers").on_attach,
    capabilities = require("config.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.server_config." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end
