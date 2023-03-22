local M = {
  servers = {
    "clangd",
    "html",
    "cssls",
    "tsserver",
    "lua_ls",
    "pyright",
    "rust_analyzer",
  },
}

function M:setup()
  require("mason-lspconfig").setup({
    ensure_installed = self.servers,
    automatic_installation = false,
  })
  return self.servers
end

return M
