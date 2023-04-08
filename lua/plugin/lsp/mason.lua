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
  utils = {
    "blue",
    "stylua",
    "shfmt",
    "shellcheck",
    "jsonlint",
    "prettierd",
  },
}

function M.query_utils(pkg_list)
  pkg_list = pkg_list or M.utils
  for _, p in pairs(pkg_list) do
    local pkg = require("mason-registry").get_package(p)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

function M:setup_servers()
  require("mason-lspconfig").setup({
    ensure_installed = self.servers,
    automatic_installation = false,
  })
  return self.servers
end

return M
