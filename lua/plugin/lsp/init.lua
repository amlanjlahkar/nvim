local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig",
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
  require("plugin.lsp.ui"):setup()
  local s = require("plugin.lsp.server"):setup()
  if s.installed then
    for _, server in pairs(s.servers) do
      local opts = {
        on_attach = require("plugin.lsp.handler").on_attach,
        capabilities = require("plugin.lsp.handler").capabilities,
      }
      local has_custom_opts, server_custom_opts = pcall(require, "plugin.lsp.server_config." .. server)
      if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
      end
      require("lspconfig")[server].setup(opts)
    end
  end
  require("plugin.null-ls").setup()
end

return M