local M = {
  servers = {
    "clangd",
    "html",
    "cssls",
    "tsserver",
    "lua_ls",
    "pyright",
  },
}

function M:setup()
  local mason_lspconfig = require("mason-lspconfig")
  local installed = mason_lspconfig.get_installed_servers()
  if #installed > 0 then
    self.installed = true
  else
    self.installed = false
    mason_lspconfig.setup({
      ensure_installed = M.servers,
      automatic_installation = false,
    })
  end
  return self
end

return M
