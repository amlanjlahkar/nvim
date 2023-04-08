return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "j-hui/fidget.nvim", opts = {
        text = { spinner = "dots", done = " " },
      } },
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            border = "single",
            icons = {
              package_installed = "",
              package_pending = "",
              package_uninstalled = "",
            },
          },
        },
      },
      "williamboman/mason-lspconfig",
      "folke/neodev.nvim",
    },
    config = function()
      require("neodev").setup()
      local installed = require("plugin.lsp.mason"):setup_servers()
      for _, server in pairs(installed) do
        local opts = {
          on_attach = require("plugin.lsp.config").on_attach,
          capabilities = require("plugin.lsp.config").capabilities,
        }
        local has_custom_opts, server_custom_opts = pcall(require, "plugin.lsp.server_config." .. server)
        if has_custom_opts then
          opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
        end
        require("lspconfig")[server].setup(opts)
      end
      require("plugin.lsp.handler").setup()
      require("plugin.lsp.ui"):setup()
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "sh", "bash", "yaml", "yml", "json" },
    event = "LspAttach",
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics

      require("plugin.lsp.mason").query_utils()
      null_ls.setup({
        sources = {
          formatting.stylua,
          formatting.black,
          formatting.prettierd,
          formatting.shfmt.with({
            extra_args = { "-i", "2", "-ci", "-bn" },
            extra_filetypes = { "bash" },
          }),
          formatting.rustfmt.with({ extra_args = { "--edition=2021" } }),
          diagnostics.shellcheck.with({
            extra_filetypes = { "sh" },
          }),
          diagnostics.jsonlint,
          diagnostics.eslint.with({
            prefer_local = "node_modules/.bin",
            condition = function(utils)
              return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js" })
            end,
          }),
        },
      })
      if not package.loaded["lsp"] then
        require("plugin.lsp.handler").setup()
        require("plugin.lsp.ui"):setup()
        require("plugin.lsp.config").keymaps(0)
      end
    end,
  },
}
