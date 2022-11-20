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
  "pyright",
}

local M = {}

function M.pass_servers()
  return servers
end

function M:setup_server()
  local installed = mason_lspconfig.get_installed_servers()
  if #installed ~= 0 then
    self.is_installed = true
    for _, server in pairs(installed) do
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
  end
  return self
end

return M
