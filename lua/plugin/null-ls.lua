local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = "LspAttach",
  ft = { "sh", "bash", "yaml", "yml", "json" },
}

function M.config()
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

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
end

function M.format()
  vim.lsp.buf.format({
    filter = function(client)
      local use_builtin = { "clangd", "jdtls" }
      for _, v in pairs(use_builtin) do
        if client.name == v then
          return client.name ~= "null-ls"
        end
      end
      return client.name == "null-ls"
    end,
    timeout_ms = 5000,
    async = true,
  })
end

return M
