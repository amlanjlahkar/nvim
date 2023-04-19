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
      local servers = require("plugin.lsp.mason"):setup_servers()
      for _, server in pairs(servers) do
        local opts = require("plugin.lsp.equip_opts").setup(server)
        require("lspconfig")[server].setup(opts)
      end
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
        on_attach = function(_, bufnr)
          local default = require("plugin.lsp.def_opts")
          local ui = require("plugin.lsp.ui")
          if not package.loaded["lsp"] then
            default.handlers()
            default.keymaps(bufnr)
            ui:setup()
            vim.diagnostic.config(ui:diagnostic_opts())
          end
        end,
      })
    end,
  },

  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = {
      server = require("plugin.lsp.equip_opts").setup("clangd"),
    },
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      require("plugin.lsp.server_settings.jdtls")
    end,
  }
}
