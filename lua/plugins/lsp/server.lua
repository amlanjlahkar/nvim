local M = {
  servers = {
    "clangd",
    "html",
    "cssls",
    "tsserver",
    "sumneko_lua",
    "pyright",
  },
}

function M:setup_server()
  local installed = require("mason-lspconfig").get_installed_servers()
  if #installed > 0 then
    self.is_installed = true
    for _, server in pairs(installed) do
      local opts = {
        on_attach = require("plugins.lsp.handler").on_attach,
        capabilities = require("plugins.lsp.handler").capabilities,
      }
      local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.server_config." .. server)
      if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
      end
      require("lspconfig")[server].setup(opts)
    end
  else
    self.is_installed = false
    require("mason-lspconfig").setup({
      ensure_installed = M.servers,
      automatic_installation = false,
    })
  end
  return self
end

return M
