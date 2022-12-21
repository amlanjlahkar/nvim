local M = {
  "neovim/nvim-lspconfig",
  ft = "lua",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig",
    "jose-elias-alvarez/null-ls.nvim",
    "folke/trouble.nvim",
  },
  config = function()
    require("plugins.lsp.ui")
    local server = require("plugins.lsp.server"):setup_server()
    if server.is_installed then
      require("plugins.lsp.null-ls")
    end
  end
}

return M
