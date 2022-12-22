local M = {
  "neovim/nvim-lspconfig",
  ft = "lua",
  dependencies = {
    "williamboman/mason-lspconfig",
  },
}

function M.config()
  require("plugins.lsp.ui"):setup()
  local s = require("plugins.lsp.server"):setup()
  if s.installed then
    for _, server in pairs(s.servers) do
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
  end
  require("plugins.null-ls").setup()
end

return M
