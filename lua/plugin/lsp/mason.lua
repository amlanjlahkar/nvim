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

function M.install_utils()
  local utils = {
    "blue",
    "stylua",
    "shfmt",
    "shellcheck",
    "jsonlint",
    "prettierd",
  }
  for _, p in pairs(utils) do
    local pkg = require("mason-registry").get_package(p)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end

function M:setup()
  local ensured = {}
  for _, server in pairs(self.server_spec) do
    if server.auto_install then
      table.insert(ensured, server[1])
    end
  end
  require("mason-lspconfig").setup({
    ensure_installed = ensured,
    automatic_installation = false,
  })
  self.install_utils()
end

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Install missing mason packages",
  group = vim.api.nvim_create_augroup("_mason", { clear = true }),
  pattern = vim.fn.stdpath("config") .. "/lua/plugin/lsp/mason.lua",
  callback = function()
    M:setup()
  end,
})

return M
