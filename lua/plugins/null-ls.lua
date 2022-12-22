local M = {
  "jose-elias-alvarez/null-ls.nvim",
}

function M.setup()
  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  null_ls.setup({
    sources = {
      formatting.stylua,
      formatting.black,
      formatting.prettier.with({
        prefer_local = "node_modules/.bin",
      }),
      formatting.shfmt.with({
        extra_args = { "-i", "2", "-ci", "-bn" },
        extra_filetypes = { "bash" },
      }),
      diagnostics.shellcheck.with({
        extra_filetypes = { "sh" },
      }),
      diagnostics.jsonlint,
    },
  })
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
