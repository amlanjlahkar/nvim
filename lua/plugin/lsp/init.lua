local schedule_install = require("plugin.lsp.mason").schedule_install
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ui = {
        border = "none",
        width = 0.6,
        height = 0.8,
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      vim.api.nvim_create_autocmd("BufWritePost", {
        desc = "Install missing mason packages",
        group = vim.api.nvim_create_augroup("_Mason", { clear = true }),
        pattern = vim.fn.stdpath("config") .. "/lua/plugin/lsp/schema.lua",
        callback = function()
          require("plenary.reload").reload_module("plugin.lsp.schema")
          schedule_install()
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "j-hui/fidget.nvim", opts = {
        text = { spinner = "dots", done = " " },
      } },
      "folke/neodev.nvim",
    },
    config = function()
      vim.lsp.set_log_level("DEBUG")
      local root = require("mason.settings").current.install_root_dir .. "/packages"
      if not vim.loop.fs_access(root, "R") then
        schedule_install()
        return
      end
      require("neodev").setup()
      local node_loaded = vim.fn.executable("node") == 1
      for _, server in pairs(require("plugin.lsp.schema")) do
        if type(server.hook_lspconfig) == "boolean" and server.hook_lspconfig then
          if not node_loaded and server.require_node then
            goto continue
          end
          local opts = require("plugin.lsp.equip_opts").setup(server[1])
          require("lspconfig")[server[1]].setup(opts)
          ::continue::
        end
      end
      require("lspconfig.ui.windows").default_options.border = "single"
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "sh", "bash", "yaml", "yml", "json" },
    event = "LspAttach",
    opts = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      return {
        sources = {
          formatting.black,
          formatting.prettierd,
          formatting.stylua,
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
        on_attach = function(client, bufnr)
          local default = require("plugin.lsp.def_opts")
          if not package.loaded["lsp"] then
            default.handlers()
            default.on_attach(client, bufnr)
          end
        end,
      }
    end,
  },

  { "mfussenegger/nvim-jdtls", enabled = false },

  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    opts = {
      server = require("plugin.lsp.equip_opts").setup("clangd"),
    },
  },

  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "javascript", "typescript" },
    opts = {
      server = require("plugin.lsp.equip_opts").setup("tsserver"),
    },
  },
}
