local M = {}

M.server_spec = {
  { "clangd", require_node = false, hook_lspconfig = false, auto_install = true },
  { "html", require_node = true, hook_lspconfig = true, auto_install = true },
  { "cssls", require_node = true, hook_lspconfig = true, auto_install = true },
  { "lua_ls", require_node = false, hook_lspconfig = true, auto_install = true },
  { "pyright", require_node = true, hook_lspconfig = true, auto_install = true },
  { "rust_analyzer", require_node = false, hook_lspconfig = true, auto_install = false },
  { "tsserver", require_node = true, hook_lspconfig = false, auto_install = true },
}

function M:ensured_servers()
  local node_loaded = vim.fn.executable("node") == 1
  local ensured = {}
  for _, server in pairs(self.server_spec) do
    if server.auto_install then
      if not node_loaded and server.require_node then
        goto continue
      end
      table.insert(ensured, server[1])
      ::continue::
    end
  end
  return ensured
end

function M.ensured_addons()
  local addons = {
    "blue",
    "jsonlint",
    "prettierd",
    "shellcheck",
    "shfmt",
    "stylua",
  }
  local ensured = {}
  local registry = require("mason-registry")
  local is_avail, addon
  for _, a in pairs(addons) do
    is_avail, addon = pcall(registry.get_package, a)
    if is_avail then
      if not registry.is_installed(a) then
        table.insert(ensured, addon)
      end
    end
  end
  return ensured
end

function M:install_ensured()
  for _, addon in pairs(self.ensured_addons()) do
    addon:install()
  end
  require("mason-lspconfig").setup({
    ensure_installed = self:ensured_servers(),
    automatic_installation = false,
  })
end

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Install missing mason packages",
  group = vim.api.nvim_create_augroup("_Mason", { clear = true }),
  pattern = vim.fn.stdpath("config") .. "/lua/plugin/lsp/mason.lua",
  callback = function()
    M:install_ensured()
  end,
})

return M
