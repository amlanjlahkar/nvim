local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig",
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
  },
  lazy = false,
}

function M.config()
  local installed = require("plugin.lsp.server"):setup()
  for _, server in pairs(installed) do
    local opts = {
      on_attach = require("plugin.lsp.config").on_attach,
      capabilities = require("plugin.lsp.config").capabilities,
    }
    local has_custom_opts, server_custom_opts = pcall(require, "plugin.lsp.server_config." .. server)
    if has_custom_opts then
      opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end
    if vim.bo.filetype == "lua" then
      require("neodev").setup()
    end
    require("lspconfig")[server].setup(opts)
  end
  require("plugin.lsp.handler").setup()
  require("plugin.lsp.ui"):setup()
end

return M
