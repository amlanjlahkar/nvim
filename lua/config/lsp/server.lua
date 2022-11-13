local is_available, mason_lspconfig = pcall(require, "mason-lspconfig")
if not is_available then
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

local M = {}

function M:setup_server()
  if next(mason_lspconfig.get_installed_servers()) == nil then
    vim.notify("Installing language servers...", vim.log.levels.INFO)
    mason_lspconfig.setup({
      ensure_installed = servers,
      automatic_installation = false,
    })
  else
    for _, server in pairs(servers) do
      local opts = {
        on_attach = require("config.lsp.handler").on_attach,
        capabilities = require("config.lsp.handler").capabilities,
      }
      local has_custom_opts, server_custom_opts = pcall(require, "config.lsp.server_config." .. server)
      if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
      end
      require("lspconfig")[server].setup(opts)
    end
    self.is_installed = true
  end
  return self
end

return M
