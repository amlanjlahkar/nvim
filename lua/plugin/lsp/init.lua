local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig",
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
  },
  ft = {
    "c",
    "objc",
    "cpp",
    "objcpp",
    "lua",
    "html",
    "css",
    "javascript",
    "java",
    "python",
    "sh",
    "bash",
    "json",
    "yaml",
  },
}

function M.config()
  local s = require("plugin.lsp.server"):setup()
  if s.installed then
    for _, server in pairs(s.servers) do
      local opts = {
        on_attach = require("plugin.lsp.config").on_attach,
        capabilities = require("plugin.lsp.config").capabilities,
      }
      local has_custom_opts, server_custom_opts = pcall(require, "plugin.lsp.server_config." .. server)
      if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
      end
      if server == "sumneko_lua" then
        require("neodev").setup()
      end
      require("lspconfig")[server].setup(opts)
    end
  end
  require("plugin.lsp.handler").setup()
  require("plugin.lsp.ui"):setup()
  require("plugin.null-ls").setup()
end

return M
